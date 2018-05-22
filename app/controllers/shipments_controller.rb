class ShipmentsController < ApplicationController
  before_action :authenticate_shipper!, except: [:index, :show, :results_carrier]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :check_available, only: [:edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: :results_carrier

  def results_carrier
    @shipment = Shipment.new
    authorize @shipment

    @query = query_params

    @all_carriers_two_conditions =
      Carrier.where(
              "array_to_string(areas_covered, '||') ILIKE ? AND
               array_to_string(areas_covered, '||') ILIKE ? AND
               favorite_products @> ARRAY[?]::varchar[] AND
               visible = true",
               "%" + @query[:pickup_prefecture].gsub(/\A[\p{Zs}\p{Cf}]+|[\p{Zs}\p{Cf}]+\Z/, '') + "%",
               "%" + @query[:delivery_prefecture].gsub(/\A[\p{Zs}\p{Cf}]+|[\p{Zs}\p{Cf}]+\Z/, '') + "%",
               @query[:category]
              )

      # Carrier.where("areas_covered @> ARRAY[?]::varchar[] AND favorite_products @> ARRAY[?]::varchar[] AND visible = true",
                    # [@query[:pickup_prefecture], @query[:delivery_prefecture]], @query[:category])

    if @query[:temperature] == Shipment::QUERY_ALL
      @results_with_temp = @all_carriers_two_conditions
    elsif @query[:temperature] == Shipment::QUERY_NORMAL_TEMP
      @results_with_temp =
        @all_carriers_two_conditions
          .joins(:vehicles)
          .where(vehicles: {feature: Shipment::QUERY_NORMAL_TEMP_VEHICLES})
          .distinct
    else
      @results_with_temp =
        @all_carriers_two_conditions
          .joins(:vehicles)
          .where(vehicles: {feature: @query[:temperature]})
          .distinct
    end
  end

  def index
    if params[:search].present? && params[:search][:p_start_date].present?
      selected_p_start_date = Date.parse(params[:search][:p_start_date])
    end

    if params[:search].present? && params[:search][:d_start_date].present?
      selected_d_start_date = Date.parse(params[:search][:d_start_date])
    end

    @all_shipments = policy_scope(Shipment)
                      .includes(:pickups, :deliveries)
                      .where(available: true)
                      .order(created_at: :desc)

    # joins and includes (which one is faster?)
    # the results of joins and includes are different
    # 1.includes only returns the results filtered by where
    # 2.joins returns all instances that related to the results filtered by where
    if params[:search].present?
      if params[:search][:p_prefecture].present? && params[:search][:d_prefecture].present?
        after_prefecture_filter = @all_shipments
                                  .where(pickups: {prefecture: params[:search][:p_prefecture]},
                                         deliveries: {prefecture: params[:search][:d_prefecture]})

        # shipments_after_first_filter = @all_shipments.includes(:pickups)
        #                                 .where(pickups: {prefecture: params[:search][:p_prefecture]})

        # shipments_ids = shipments_after_first_filter.map do |shipment|
        #   shipment.id
        # end

        # shipments_after_filter = @all_shipments.includes(:deliveries)
        #                           .where(id: shipments_ids, deliveries: {prefecture: params[:search][:d_prefecture]})

      elsif params[:search][:p_prefecture].present?
        after_prefecture_filter = @all_shipments
                                  .where(pickups: {prefecture: params[:search][:p_prefecture]})

      elsif params[:search][:d_prefecture].present?
        after_prefecture_filter = @all_shipments
                                  .where(deliveries: {prefecture: params[:search][:d_prefecture]})
      else
        after_prefecture_filter = @all_shipments
      end

      if params[:search][:p_start_date].present? && params[:search][:d_start_date].present?
        after_all_filters = after_prefecture_filter
                              .where(pickups: {start_date: selected_p_start_date},
                                     deliveries: {start_date: selected_d_start_date})

      elsif params[:search][:p_start_date].present?
        after_all_filters = after_prefecture_filter
                              .where(pickups: {start_date: selected_p_start_date})

      elsif params[:search][:d_start_date].present?
        after_all_filters = after_prefecture_filter
                              .where(deliveries: {start_date: selected_d_start_date})
      else
        after_all_filters = after_prefecture_filter
      end
    else
      after_all_filters = @all_shipments
    end

    @shipments = after_all_filters.map do |shipment|
      {
        shipment: shipment,

        # .first needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: shipment.pickups.first,
        delivery: shipment.deliveries.first,
      }
    end
  end

  def show
    # .first needs to be changed after modifying
    # shipment form to allow users to add more than 2 pickups or deliveries.
    @pickup = @shipment.pickups.first
    @delivery = @shipment.deliveries.first
    @deal = @shipment.deals.build

    if current_carrier
      @carrier_deal = current_carrier.deals.find_by(shipment: @shipment)
      if @carrier_deal && (@carrier_deal.deal_status == 'requesting')
        @message = "You've already booked the shipment."
      elsif @carrier_deal && (@carrier_deal.deal_status == 'bidding')
        @message = "You're already bidding for the shipment."
      end
    end
  end

  def new
    @shipment = Shipment.new
    @shipment.pickups.build
    @shipment.deliveries.build
    authorize @shipment

    respond_to do |format|
      format.html
      format.json do
        @selected_facility_id = new_form_params[:id].to_i
        @selected_facility = Facility.find(@selected_facility_id)
      end
    end
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.available = true
    @shipment.shipper = current_shipper

    authorize @shipment # use before saving(@shipmen.save) it in a database.
    if @shipment.save
      redirect_to shipper_shipment_path(@shipment)
      flash[:notice] = "Your shipment has been created"
    else
      render :new
    end
  end

  def edit
    limit_access_to

    respond_to do |format|
      format.html
      format.json do
        @selected_facility_id = new_form_params[:id].to_i
        @selected_facility = Facility.find(@selected_facility_id)
      end
    end
  end

  def update
    # how can we show the form if pickup or devliery info is more than two??
   # 1. <%#= f.simple_fields_for :pickups, f.object.pickups.first do |p| %>
   #  => generate edit form for one instance of pickups

   # 2. <%#= f.simple_fields_for :pickups do |p| %>
   #  => generate edit form for all instances of pickups automatically

    if @shipment.update(shipment_params)
      redirect_to shipper_shipment_path(@shipment)
      flash[:notice] = "Your shipment has been edited"
    else
      render :edit
    end
  end

  def destroy
    limit_access

    @shipment.destroy
    redirect_to shipper_shipments_path
    flash[:notice] = "Your shipment has been deleted"
  end

  private

  def query_params
    params.require(:query).permit(:category, :temperature, :pickup_post_code, :pickup_prefecture,
      :pickup_ward, :delivery_post_code, :delivery_prefecture, :delivery_ward )
  end

  def shipment_params
    params
      .require(:shipment)
      .permit(:duration_start, :duration_end, :frequency, :available,
        # pickups_attributes: [:id, :company_name, :prefecture, :address, :commodity, :weight, :start_date, :end_date],
        pickups_attributes: Pickup.attribute_names.map(&:to_sym).push(:_destroy),
        deliveries_attributes: Delivery.attribute_names.map(&:to_sym).push(:_destroy))
  end

  def set_shipment
    @shipment = Shipment.find(params[:id])
    authorize @shipment
  end

  def limit_access_to
    if @shipment.deals.present?
      redirect_to shipper_shipments_path
    end
  end

  def check_available
    if @shipment.available == false
      redirect_to shipper_shipment_path(@shipment)
    end
  end

  def new_form_params
    params.require(:facility).permit(:id)
  end
end
