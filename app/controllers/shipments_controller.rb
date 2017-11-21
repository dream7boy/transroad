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
    @shipment.locations.build

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
    if @shipment.save
      redirect_to shipment_path(@shipment)
      flash[:notice] = "Your shipment has been created"
    else
      # temporary solution
      @shipment = Shipment.new
      @shipment.locations.build

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

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
