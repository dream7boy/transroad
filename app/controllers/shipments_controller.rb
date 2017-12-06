class ShipmentsController < ApplicationController
  before_action :authenticate_shipper!, except: [:index, :show]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :check_available, only: [:edit, :update, :destroy]

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
      format.html { render "shipments/new" }
      format.json do
        @selected_facility_id = new_form_params[:id].to_i
        @selected_facility = Facility.find(@selected_facility_id)
      end
    end
    # byebug
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
    @shipment.destroy
    redirect_to shipper_shipments_path
    flash[:notice] = "Your shipment has been deleted"
  end

  private

  def shipment_params
    params.require(:shipment).permit(:distance, :offer_rate, :car_type, :available,
      pickups_attributes: [:id, :company_name, :prefecture, :address, :commodity, :weight, :start_date, :end_date],
      deliveries_attributes: [:id, :company_name, :prefecture, :address, :start_date, :end_date])
  end

  def set_shipment
    @shipment = Shipment.find(params[:id])
    authorize @shipment
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
