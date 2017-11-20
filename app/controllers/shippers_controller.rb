class ShippersController < ApplicationController
  before_action :authenticate_shipper!

  def cargos
    @cargos = current_shipper.shipments
  end

end
