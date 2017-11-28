class DealsController < ApplicationController
  before_action :authenticate_carrier!

  def index
    @all_deals = policy_scope(Deal).order(created_at: :desc)

    @deals = @all_deals.map do |deal|
      {
        deal: deal,

        # find_by(is_for) needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: deal.shipment.locations.find_by(is_for: 'pickup'),
        delivery: deal.shipment.locations.find_by(is_for: 'delivery')
      }
    end
  end

  def create
    @shipment = Shipment.find(shipment_params)
    @deal = @shipment.deals.build
    @deal.deal_status = 'requesting'
    @deal.carrier = current_carrier
    authorize @deal
    if @deal.save
      redirect_to carrier_shipments_path
      flash[:notice] = "Your booking has been made"
    else
      render 'shipments/show'
    end
  end

  def pre_transit_index
    # 1.
    # all_won_deals = policy_scope(Deal).where(deal_status: 'won').order(created_at: :asc)
    # @deals = all_won_deals.includes(:shipment).where(shipments: {transit_status: 'pre-transit'})

    # 2.
    # @deals = policy_scope(Deal).includes(:shipment).where(deal_status: 'won', shipments: {transit_status: 'pre-transit'})

    @deals = policy_scope(Deal)
              .includes(:shipment)
              .where(deal_status: 'won', shipments: {transit_status: 'pre-transit'})
              .order(created_at: :asc)

    authorize @deals
  end

  def to_in_transit
    @deal = Deal.find(deal_params[:id])
    authorize @deal
    @deal.shipment.update(transit_status: 'in-transit')
    redirect_to carrier_shipments_pre_transit_path
  end

  def in_transit_index
    @deals = policy_scope(Deal)
              .includes(:shipment)
              .where(deal_status: 'won', shipments: {transit_status: 'in-transit'})
              .order(created_at: :asc)

    authorize @deals
  end

  def to_post_transit
    @deal = Deal.find(deal_params[:id])
    authorize @deal
    @deal.shipment.update(transit_status: 'post-transit')
    redirect_to carrier_shipments_in_transit_path
  end

  def post_transit_index
    @deals = policy_scope(Deal)
              .includes(:shipment)
              .where(deal_status: 'won', shipments: {transit_status: 'post-transit'})
              .order(created_at: :asc)

    authorize @deals
  end

  private

  def shipment_params
    params.require(:shipment_id)
  end

  def deal_params
    params.require(:deal).permit(:id)
  end
end
