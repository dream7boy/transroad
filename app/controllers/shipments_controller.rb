class ShipmentsController < ApplicationController
  def index
    @shipments = Shipment.all
  end

  def show

  end
end
