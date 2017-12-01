class Shipper::ShipmentsController < ApplicationController
  before_action :authenticate_shipper!
  before_action :set_shipment, only: [:show, :update]

  def index
    @all_shipments = policy_scope(Shipment)
                      .where(shipper: current_shipper)
                      .order(created_at: :desc)

    @shipments = @all_shipments.map do |shipment|
      {
        shipment: shipment,

        # .first needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: shipment.pickups.first,
        delivery: shipment.deliveries.first,
        deal:
          if shipment.deals.blank?
            { status: '入札なし' }
          else
            if deal = shipment.deals.find_by(deal_status: 'won')
              { carrier: deal.carrier,
                status: '落札済' }
            else
              { status: '入札あり' }
            end
          end
      }
    end
  end

  def show
    # .first needs to be changed after modifying
    # shipment form to allow users to add more than 2 pickups or deliveries.
    @pickup = @shipment.pickups.first
    @delivery = @shipment.deliveries.first
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
    @all_shipments = policy_scope(Shipment)
                      .where(shipper: current_shipper, transit_status: 'pre-transit')
                      .order(created_at: :desc)

    @shipments = @all_shipments.map do |shipment|
      {
        shipment: shipment,

        # .first needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: shipment.pickups.first,
        delivery: shipment.deliveries.first,
        deal: shipment.deals.find_by(deal_status: 'won')
      }
    end
    authorize @all_shipments
  end

  def in_transit_index
    @shipments = policy_scope(Shipment)
                  .where(shipper: current_shipper, transit_status: 'in-transit')
                  .order(created_at: :desc)

    authorize @shipments
  end

  def post_transit_index
    @shipments = policy_scope(Shipment)
                  .where(shipper: current_shipper, transit_status: 'post-transit')
                  .order(created_at: :desc)

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
