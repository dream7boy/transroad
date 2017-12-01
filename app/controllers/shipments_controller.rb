class ShipmentsController < ApplicationController
  before_action :authenticate_shipper!, except: [:index, :show]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :check_available, only: [:edit, :update, :destroy]

  def index
    @all_shipments = policy_scope(Shipment)
                      .where(available: true)
                      .order(created_at: :desc)

    # joins and includes (which one is faster?)
    if params[:search].present?
      if params[:search][:p_prefecture].present? && params[:search][:d_prefecture].present?
        shipments_after_first_filter = @all_shipments.includes(locations: :facility)
                                          .where(locations: {is_for: 'pickup'},
                                          facilities: {prefecture: params[:search][:p_prefecture]})

        shipments_ids = shipments_after_first_filter.map do |shipment|
          shipment.id
        end

        shipments_after_filter = @all_shipments.includes(locations: :facility)
                                    .where(id: shipments_ids, locations: {is_for: 'delivery'},
                                    facilities: {prefecture: params[:search][:d_prefecture]})

      elsif params[:search][:p_prefecture].present?
        shipments_after_filter = @all_shipments.includes(locations: :facility)
                                    .where(locations: {is_for: 'pickup'},
                                    facilities: {prefecture: params[:search][:p_prefecture]})

      elsif params[:search][:d_prefecture].present?
        shipments_after_filter = @all_shipments.includes(locations: :facility)
                                    .where(locations: {is_for: 'delivery'},
                                    facilities: {prefecture: params[:search][:d_prefecture]})
      else
        shipments_after_filter = @all_shipments
      end
    else
      shipments_after_filter = @all_shipments
    end

    @shipments = shipments_after_filter.map do |shipment|
      {
        shipment: shipment,

        # find_by(is_for) needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: shipment.locations.find_by(is_for: 'pickup'),
        delivery: shipment.locations.find_by(is_for: 'delivery')
      }
    end
  end

  def show
    @pickups = @shipment.pickups.order(created_at: :asc)
    @deliveries = @shipment.deliveries.order(created_at: :asc)
    @deal = @shipment.deals.build

    if current_carrier
      @carrier_deal = current_carrier.deals.find_by(shipment: @shipment)
      if @carrier_deal && @carrier_deal.deal_status == 'requesting'
        @message = "You've already booked the shipment."
      elsif @carrier_deal && @carrier_deal.deal_status == 'bidding'
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
    @shipment.shipper = current_shipper

    authorize @shipment # use before saving(@shipmen.save) it in a database.
    if @shipment.save
      redirect_to @shipment
      flash[:notice] = "Your shipment has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
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
