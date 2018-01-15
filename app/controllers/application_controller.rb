class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :user, contains: [:shipper, :carrier]
  before_action :authenticate_user! # Ensure someone is logged in
  # add more columns to users table
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    if current_shipper.present?
      redirect_to(shipper_shipments_path)
    else
      redirect_to(carrier_shipments_path)
    end
  end

  # add more columns to users table
  protected

  def configure_permitted_parameters
    added_attrs =
      [ :company_name, :post_code, :prefecture, :ward, :street, :name_kanji,
        :name_furigana, :phone, :areas_covered, :favorite_products, :industry,
        vehicles_attributes: [:id, :size, :vehicle_type, :quantity, :_destroy]]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # Pundit
  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
