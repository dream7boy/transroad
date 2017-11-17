class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  devise_group :user, contains: [:shipper, :carrier]
  before_action :authenticate_user! # Ensure someone is logged in
end
