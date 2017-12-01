class ShipmentsController < ApplicationController
  before_action :authenticate_shipper!, except: [:index, :show]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :check_available, only: [:edit, :update, :destroy]

  def index
    @all_shipments = policy_scope(Shipment)
                      .where(available: true)
                      .order(created_at: :desc)

    # joins and includes (which one is faster?)
    # the results of joins and includes are different
    # 1.includes only returns the results filtered by where
    # 2.joins returns all instances that related to the results filtered by where
    if params[:search].present?
      if params[:search][:p_prefecture].present? && params[:search][:d_prefecture].present?
        shipments_after_filter = @all_shipments.includes(:pickups, :deliveries)
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
        shipments_after_filter = @all_shipments.includes(:pickups)
                                  .where(pickups: {prefecture: params[:search][:p_prefecture]})

      elsif params[:search][:d_prefecture].present?
        shipments_after_filter = @all_shipments.includes(:deliveries)
                                  .where(deliveries: {prefecture: params[:search][:d_prefecture]})
      else
        shipments_after_filter = @all_shipments
      end
    else
      shipments_after_filter = @all_shipments
    end

    @shipments = shipments_after_filter.map do |shipment|
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
      pickups_attributes: [:id, :company_name, :prefecture, :address, :commodity, :weight],
      deliveries_attributes: [:id, :company_name, :prefecture, :address])
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
end
