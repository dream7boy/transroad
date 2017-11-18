class ShippersController < ApplicationController
  protect_from_forgery
  before_action :authenticate_shipper!

  def cargos
    @cargos = current_shipper.shipments
  end

end
