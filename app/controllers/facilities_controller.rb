class FacilitiesController < ApplicationController
  before_action :authenticate_shipper!
  before_action :set_facility, only: [:edit, :update, :destroy]

  def index
    # @facilities = current_shipper.facilities.order(created_at: :asc)
    @facilities = policy_scope(Facility).order(created_at: :desc)
  end

  def new
    @facility = Facility.new
    authorize @facility
  end

  def create
    @facility = Facility.new(facility_params)
    @facility.shipper = current_shipper
    authorize @facility
    if @facility.save
      redirect_to facilities_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @facility.update(facility_params)
    redirect_to facilities_path
    flash[:notice] = "Your facility has been edited"
  end

  def destroy
    if @facility.locations.blank?
      @facility.destroy
      redirect_to facilities_path
      flash[:notice] = "Your facility has been deleted"
    else
      redirect_to facilities_path
      flash[:alert] = "Your facility has been used"
    end
  end

  private

  def facility_params
    params.require(:facility).permit(:name, :prefecture, :address)
  end

  def set_facility
    @facility = Facility.find(params[:id])
    authorize @facility
  end
end
