class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  def index
    @shipments = Shipment.all
  end

  def show
  end

  def new
    @shipment = Shipment.new
  end

  def edit
  end

  def update
    @shipment.update(shipment_params)
    redirect_to cargos_path
    flash[:notice] = "Your shipment has been edited"
  end

  def create
    @shipment = Shipment.new(shipment_params)
    @shipment.shipper = current_shipper
    if @shipment.save
      redirect_to shipment_path(@shipment)
    else
      render :new
    end
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

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
