class ShipmentsController < ApplicationController
  before_action :authenticate_shipper!, except: [:index, :show]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  before_action :check_available, only: [:edit, :update, :destroy]

  def index
    # @all_shipments = Shipment.all.order(created_at: :desc)
    @all_shipments = policy_scope(Shipment).where(available: true).order(created_at: :desc)

    @shipments = @all_shipments.map do |shipment|
      {
        shipment: shipment,
        pickup: {
          # find_by(is_for) needs to be changed after modifying
          # shipment form to allow users to add more than 2 pickups or deliveries.
          prefecture: shipment.locations.find_by(is_for: "pickup").facility.prefecture,
          address: shipment.locations.find_by(is_for: "pickup").facility.address
        },
        delivery: {
          prefecture: shipment.locations.find_by(is_for: "delivery").facility.prefecture,
          address: shipment.locations.find_by(is_for: "delivery").facility.address
        }
      }
    end
  end

  def show
    @locations = @shipment.locations.order(created_at: :asc)
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
    @shipment.locations.build
    authorize @shipment

    # 2.times { @shipment.locations.build }

    # if @shipment.locations.empty?
    #   @shipment.locations.build
    # end
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.shipper = current_shipper

    # @pickup = @shipment.locations.build(location_params)
    # @delivery = @shipment.locations.build(delivery_params)

    # @pickup = Location.new(pickup_params)
    # @delivery = Location.new(delivery_params)

    authorize @shipment # use before saving(@shipmen.save) it in a database.
    if @shipment.save
      redirect_to @shipment
      flash[:notice] = "Your shipment has been created"
    else
      # temporary solution
      # @shipment = Shipment.new
      # @shipment.locations.build

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
    params.require(:shipment).permit(:distance, :rate, :car_type, :available,
      locations_attributes: [:id, :facility_id, :commodity, :weight, :is_for, :_destroy])
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
