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
      redirect_to shipment_path(@shipment)
      flash[:notice] = "Your booking has been made"
    else
      redirect_to shipment_path(@shipment)
      flash[:alert] = "Your booking has not been made"
    end
  end

  private

  def shipment_params
    params.require(:shipment_id)
  end

  # def deal_params
  #   params.require(:deal).permit(:deal_status)
  # end
end
