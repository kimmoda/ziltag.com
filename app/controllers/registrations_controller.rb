class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers

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

end