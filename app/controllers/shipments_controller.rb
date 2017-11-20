class ShipmentsController < ApplicationController
  before_action :authenticate_shipper!, except: [:index, :show]
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  def index
    @shipments = Shipment.all
  end

  def show
  end

  def new
    @shipment = Shipment.new

    # @shipment.locations.build

    # if @shipment.locations.empty?
    #   @shipment.locations.build
    # end
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.shipper = current_shipper

    # @pickup = @shipment.locations.build
    # @delivery = @shipment.locations.build

    # @pickup = @shipment.locations.build(location_params)
    # @delivery = @shipment.locations.build(delivery_params)

    # @pickup = Location.new(pickup_params)
    # @delivery = Location.new(delivery_params)
    if @shipment.save
      redirect_to shipment_path(@shipment)
      flash[:notice] = "Your shipment has been created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @shipment.update(shipment_params)
      redirect_to cargos_path
      flash[:notice] = "Your shipment has been edited"
    else
      render :edit
    end
  end

  def destroy
    @shipment.destroy
    redirect_to cargos_path
    flash[:notice] = "Your shipment has been deleted"
  end

  private

  def shipment_params
    params.require(:shipment).permit(:distance, :rate, :car_type, locations_attributes: [:id, :facility_id, :commodity, :weight, :is_for])
  end

  # 0. not needed
  # def location_params
  #   params.require(:shipment).permit(locations_attributes: [:facility_id, :commodity, :weight, :is_for])
  # end

  # 1. not work
  # def location_params
  #   params.require(:locations_attributes).permit(:facility_id, :commodity, :weight, :is_for)
  # end

  # def pickup_params
  #   params.require(:shipment).permit(:facility_id, :commodity, :weight, :is_for)
  # end

  # def delivery_params
  #   params.require(:shipment).permit(locations_attributes: '1')
  # end

  # def delivery_params
  #   params.require(:delivery).permit(:facility_id, :is_for)
  # end

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
