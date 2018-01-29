class DealsController < ApplicationController
  before_action :authenticate_carrier!, except: :create

  def index
    @all_deals = policy_scope(Deal).order(created_at: :desc)

    @deals = @all_deals.map do |deal|
      {
        deal: deal,

        # .first needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: deal.shipment.pickups.first,
        delivery: deal.shipment.deliveries.first,
      }
    end
  end

  def create
    @shipment = Shipment.find(shipment_params)
    @carriers_ids = params[:carriers][:ids].split(" ")
    @carriers_ids.each do |carrier_id|
      @deal = @shipment.deals.build(deal_status: 'new', carrier_id: carrier_id)
      authorize @deal
      @deal.save
    end
    redirect_to quotes_done_shipper_shipment_path(@shipment)

    # @deal = @shipment.deals.build(deal_status: 'requesting', carrier: current_carrier)
    # authorize @deal
    # if @deal.save
    #   redirect_to carrier_shipments_path
    #   flash[:notice] = "Your booking has been made"
    # else
    #   render 'shipments/show'
    # end
  end

  def quotes_make
    set_deal
    authorize @deal

    @deal_details = {
      shipper: @deal.shipment.shipper,
      deal: @deal,
      shipment: @deal.shipment,
      pickup: @deal.shipment.pickups.first,
      delivery: @deal.shipment.deliveries.first
    }
  end

  def quotes_update
    set_deal
    authorize @deal
    @deal.update(quote_params)
    redirect_to carrier_shipments_path
  end

  def pre_transit_index
    set_deals('pre-transit')
    @ids_for_params = []
  end

  def in_transit_index
    set_deals('in-transit')
    @ids_for_params = []
  end

  def post_transit_index
    set_deals('post-transit')
  end

  def to_next_transit
    selected_ids = []
    deal_params.each do |param|
      if ['0', 'pre_transit_index', 'in_transit_index'].exclude?(deal_params[param])
        selected_ids << deal_params[param]
      end
    end

    if selected_ids.present?
      @deals = Deal.where(id: selected_ids)
      authorize @deals
      if deal_params[:action] == 'pre_transit_index'
        @deals.each { |deal| deal.shipment.update(transit_status: 'in-transit') }
        redirect_to carrier_shipments_pre_transit_path
      else
        @deals.each { |deal| deal.shipment.update(transit_status: 'post-transit') }
        redirect_to carrier_shipments_in_transit_path
      end
    else
      @deal = Deal.new
      authorize @deal, :no_value?
      if deal_params[:action] == 'pre_transit_index'
        redirect_to carrier_shipments_pre_transit_path
      else
        redirect_to carrier_shipments_in_transit_path
      end
    end
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end

  def shipment_params
    params.require(:shipment_id)
  end

  def ids_params
    params.require(:deal).permit(:ids)
  end

  def deal_params
    ids_string = ids_params[:ids].split
    params.require(:deal).permit(ids_string, :action)
  end

  def quote_params
    params.require(:deal).permit(:bid_rate)
  end

  def set_deals(transit_status)
    # 1.
    # all_won_deals = policy_scope(Deal).where(deal_status: 'won').order(created_at: :asc)
    # @deals = all_won_deals.includes(:shipment).where(shipments: {transit_status: 'pre-transit'})

    # 2.
    # @deals = policy_scope(Deal).includes(:shipment).where(deal_status: 'won', shipments: {transit_status: 'pre-transit'})

    @all_deals = policy_scope(Deal)
                  .includes(:shipment)
                  .where(deal_status: 'won', shipments: {transit_status: transit_status})
                  .order(created_at: :desc)
    authorize @all_deals

    @deals = @all_deals.map do |deal|
      {
        deal: deal,

        # .first needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: deal.shipment.pickups.first,
        delivery: deal.shipment.deliveries.first,
      }
    end
  end
end
