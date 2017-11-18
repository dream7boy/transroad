class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :user, contains: [:shipper, :carrier]

  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user! # Ensure someone is logged in

  private

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end
end
