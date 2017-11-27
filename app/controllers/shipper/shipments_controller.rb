class Shipper::ShipmentsController < ApplicationController
  before_action :authenticate_shipper!
  before_action :set_shipment, only: [:show, :update]

  def index
    @shipments = policy_scope(Shipment)
                  .where(shipper: current_shipper)
                  .order(created_at: :desc)
  end

  def show
    @locations = @shipment.locations.order(created_at: :asc)
    authorize @shipment, :my_show?
  end

  def update
    authorize @shipment
    @shipment.deals.each do |deal|
      if deal.carrier_id == carrier_params[:carrier_id].to_i
        deal.update(deal_status: 'won')
      else
        deal.update(deal_status: 'lost')
      end
    end
    @shipment.update(available: false, transit_status: 'pre-transit')
    redirect_to shipper_shipment_path(@shipment)
    flash[:notice] = "Your Carrier has been selected"
  end

  def pre_transit_index
    @shipments = policy_scope(Shipment)
                  .where(shipper: current_shipper, transit_status: 'pre-transit')
                  .order(created_at: :asc)

    authorize @shipments
  end

  def in_transit_index
    @shipments = policy_scope(Shipment)
                  .where(shipper: current_shipper, transit_status: 'in-transit')
                  .order(created_at: :asc)

    authorize @shipments
  end

  def post_transit_index
    @shipments = policy_scope(Shipment)
                  .where(shipper: current_shipper, transit_status: 'post-transit')
                  .order(created_at: :asc)

    authorize @shipments
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end

  def carrier_params
    params.require(:shipment).permit(:carrier_id)
  end
end
