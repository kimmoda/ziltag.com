class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  respond_to :json

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      SendWelcomeEmailJob.perform_later(resource)
      SubscribeNewsletterJob.perform_later(resource)
      SendProductFeedbackToGeneralUserJob.perform_later(resource)
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: {error: resource.errors.full_messages.first}
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

private

  def set_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  end
end
