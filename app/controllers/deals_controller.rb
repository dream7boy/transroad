class DealsController < ApplicationController
  before_action :authenticate_carrier!
  # both users can make a deal??

  def index
    @deals = policy_scope(Deal).order(created_at: :desc)
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
    all_won_deals = policy_scope(Deal).where(deal_status: 'won').order(created_at: :asc)
    @deals = all_won_deals.select do |deal|
      deal.shipment.transit_status == 'pre-transit'
    end
    authorize all_won_deals
  end

  def to_in_transit
    @deal = Deal.find(deal_params[:id])
    authorize @deal
    @deal.shipment.update(transit_status: 'in-transit')
    redirect_to carrier_shipments_pre_transit_path
  end

  def in_transit_index
    all_won_deals = policy_scope(Deal).where(deal_status: 'won').order(created_at: :asc)
    @deals = all_won_deals.select do |deal|
      deal.shipment.transit_status == 'in-transit'
    end
    authorize all_won_deals
  end

  private

  def shipment_params
    params.require(:shipment_id)
  end

  def deal_params
    params.require(:deal).permit(:id)
  end
end
