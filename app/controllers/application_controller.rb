class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :user, contains: [:shipper, :carrier]
  before_action :authenticate_user! # Ensure someone is logged in
  # add more columns to users table
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  # https://www.lewagon.com/blog/setup-meta-tags-rails
  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

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
        :name_furigana, :phone, { areas_covered: [] }, { favorite_products: [] },
        :industry, :site_url, :ceo_name, :founded_date_year, :founded_date_month,
        :capital, :employee_numbers, :strength_1, :strength_2, { specialties: [] },
        :company_description, :photo, :fax,
        vehicles_attributes: Vehicle.attribute_names.map(&:to_sym).push(:_destroy)]

    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  # Pundit
  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
