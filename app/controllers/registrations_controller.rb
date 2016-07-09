class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  before_action :set_back_url

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      SendWelcomeEmailJob.perform_later(resource)
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with `resource`, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

protected

  def update_resource(resource, params)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = resource.update_attributes(params)
    resource.clean_up_passwords
    result
  end

  def after_update_path_for(resource)
    edit_registration_path(resource)
  end

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

  def set_back_url
    session[:back_url] = request.referer unless request.referer =~ /\/users/
    @back_url = session[:back_url] || session[:previous_photo_path] || root_path
  end

end
