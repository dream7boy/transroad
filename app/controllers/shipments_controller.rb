class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.all
  end

  def show
  end

  def new
    @shipment = Shipment.new
  end
end
