class Shipper::ShipmentsController < ApplicationController
  before_action :authenticate_shipper!
  before_action :set_shipment, only: [:show]

  def index
    @shipments = policy_scope(Shipment).where(shipper: current_shipper).order(created_at: :desc)
  end

  def show
    @locations = @shipment.locations.order(created_at: :asc)
    authorize @shipment, :my_show?
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end
end
