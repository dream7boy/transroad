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
        deal: if shipment.deals.blank?
                { status: '入札なし' }
              else
                if deal = shipment.deals.find_by(deal_status: 'won')
                  { carrier: deal.carrier, status: '落札済' }
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

    # @carriers = Carrier.where("areas_covered @> ?", '{東京都, 北海道}')
    # @carriers = Carrier.where("areas_covered @> ARRAY[?]::varchar[]", [@pickup.prefecture, @delivery.prefecture])
    @carriers_two_conditions =
      Carrier.where("areas_covered @> ARRAY[?]::varchar[] AND favorite_products @> ARRAY[?]::varchar[]",
                    [@pickup.prefecture, @delivery.prefecture], @pickup.category)

    @all_carriers_location_condition =
      Carrier.where("areas_covered @> ARRAY[?]::varchar[]", [@pickup.prefecture, @delivery.prefecture])

    @carriers_location_condition = @all_carriers_location_condition - @carriers_two_conditions

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

  def quotes_req
    @shipment = Shipment.find(params[:id])
    authorize @shipment
    @carriers_ids = params[:carriers][:ids].split(",")
    @carriers = Carrier.where(id: @carriers_ids)
  end

  def quotes_done
    @shipment = Shipment.find(params[:id])
    authorize @shipment
    if @shipment.deals.blank?
      redirect_to shipper_shipments_path
    end
  end

  def pre_transit_index
    set_shipments('pre-transit')
  end

  def in_transit_index
    set_shipments('in-transit')
  end

  def post_transit_index
    set_shipments('post-transit')
  end

  private

  def set_shipment
    @shipment = Shipment.find(params[:id])
  end

  def carrier_params
    params.require(:shipment).permit(:carrier_id)
  end

  def set_shipments(transit_status)
    @all_shipments = policy_scope(Shipment)
                      .where(shipper: current_shipper, transit_status: transit_status)
                      .order(created_at: :desc)
    authorize @all_shipments

    @shipments = @all_shipments.map do |shipment|
      {
        shipment: shipment,

        # .first needs to be changed after modifying
        # shipment form to allow users to add more than 2 pickups or deliveries.
        pickup: shipment.pickups.first,
        delivery: shipment.deliveries.first,
        deal: if deal = shipment.deals.find_by(deal_status: 'won')
                { carrier: deal.carrier }
              end
      }
    end
  end
end
