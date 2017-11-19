class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  def index
    @shipments = Shipment.all
  end

  def show
  end

  def new
    @shipment = Shipment.new

    # 1. cannot
    # @shipment.locations.build

    # 2. cannot
    @pickup = @shipment.locations.build
    # @delivery = @shipment.locations.build

    # 3.
    # @pickup = @shipment.locations.build

    # @pickup = Location.new
    # @delivery = Location.new
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.shipper = current_shipper

    # @pickup = @shipment.locations.build
    # @delivery = @shipment.locations.build

    @pickup = @shipment.locations.build(pickup_params)
    # @delivery = @shipment.locations.build(delivery_params)

    # @pickup = Location.new(pickup_params)
    # @delivery = Location.new(delivery_params)

    if @shipment.save && @pickup.save && @delivery.save
      redirect_to shipment_path(@shipment)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @shipment.update(shipment_params)
    redirect_to cargos_path
    flash[:notice] = "Your shipment has been edited"
  end

  def destroy
    @shipment.destroy
    redirect_to cargos_path
    flash[:notice] = "Your shipment has been deleted"
  end

  private

  def shipment_params
    params.require(:shipment).permit(:distance, :rate, :commodity, :weight, :car_type)
  end

  def pickup_params
    params.require(:pickup).permit(:facility, :commodity, :weight, :is_for)
  end

  def delivery_params
    params.require(:delivery).permit(:facility, :is_for)
  end

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
