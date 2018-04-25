class Carriers::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, only: [:edit, :update]

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def new
    @carrier = Carrier.new
    @carrier.vehicles.build
  end

  ## in case we need 2 pages for sign-up
  # def sign_up_step2
  #   @carrier = Carrier.new
  #   @carrier.attributes = carrier_params
  # end

  # POST /resource
  def create
    super
  end

  # def create
    # super

    # if resource.save
    #   # redirect_to shipper_shipment_path(@shipment)
    #   # flash[:notice] = "Welcome! You have signed up successfully."
    # else
    #   render :new
    # end
  # end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  ## in case we need 2 pages for sign-up
  # def carrier_params
  #   params.require(:carrier)
  #     .permit(Carrier.attribute_names.map(&:to_sym),
  #       { areas_covered: [] }, { favorite_products: [] }, { strengths: [] }, { specialties: [] },
  #       vehicles_attributes: Vehicle.attribute_names.map(&:to_sym).push(:_destroy))
  # end

  def after_update_path_for(resource)
    edit_carrier_registration_path(resource)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
