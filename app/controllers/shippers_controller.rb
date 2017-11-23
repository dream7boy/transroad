class ShippersController < ApplicationController
  before_action :authenticate_shipper!

  def shipments
    @shipments = current_shipper.shipments.order(created_at: :asc)
  end

end
