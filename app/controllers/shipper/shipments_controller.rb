class Shipper::ShipmentsController < ApplicationController
  before_action :authenticate_shipper!

  def index
    @shipments = policy_scope(Shipment).where(shipper: current_shipper).order(created_at: :desc)
  end
end
