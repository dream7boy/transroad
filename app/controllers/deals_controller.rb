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
      @deal.items.build
      authorize @deal
      @deal.save
    end
    # redirect_to quotes_done_shipper_shipment_path(@shipment)
    render '/shipper/shipments/quotes_done'

    # @deal = @shipment.deals.build(deal_status: 'requesting', carrier: current_carrier)
    # authorize @deal
    # if @deal.save
    #   redirect_to carrier_shipments_path
    #   flash[:notice] = "Your booking has been made"
    # else
    #   render 'shipments/show'
    # end
  end

  def new
    set_deal
  end

  def confirm
    set_deal

    permitted = params.require(:deal).permit(items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
    attributes = permitted[:items_attributes].to_h || {}

    @deal_items = attributes.map do |attribute|
      unless attribute[1][:_destroy] == "1" || attribute[1][:_destroy] == "true"
        {
          id: attribute[1][:id],
          name: attribute[1][:name],
          description: attribute[1][:description],
          price: attribute[1][:price],
          _destroy: attribute[1][:_destroy]
        }
      end
    end
    @deal_items.compact!

    @deal.attributes = quote_params
    render :new if @deal.invalid?
  end

  def update
    set_deal

    if params[:back]
      @deal.attributes = quote_params
      render :new
    elsif @deal.update(quote_params)
      # redirect_to carrier_shipments_path
      render :complete
    else
      @deal.attributes = quote_params
      render :new
    end
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
    authorize @deal

    @deal_details = {
      shipper: @deal.shipment.shipper,
      deal: @deal,
      shipment: @deal.shipment,
      pickup: @deal.shipment.pickups.first,
      delivery: @deal.shipment.deliveries.first
    }
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
    params.require(:deal).permit(:total_price,
      items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
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
