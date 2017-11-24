class Shipper::ShipmentsController < ApplicationController
  before_action :authenticate_shipper!
  before_action :set_shipment, only: [:show, :update]

  def index
    @shipments = policy_scope(Shipment).where(shipper: current_shipper).order(created_at: :desc)
  end

  def show
    @locations = @shipment.locations.order(created_at: :asc)
    authorize @shipment, :my_show?
  end

  def update
    @shipment.deals.each do |deal|
      if deal.carrier_id == carrier_params[:carrier_id].to_i
        deal.update(deal_status: 'won')
      else
        deal.update(deal_status: 'lost')
      end
    end

    authorize @shipment
    @shipment.update(available: false)
    redirect_to shipper_shipment_path(@shipment)
    flash[:notice] = "Your Carrier has been selected"
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end

  def carrier_params
    params.require(:shipment).permit(:carrier_id)
  end
end
