class RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers

protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    edit_registration_path(resource)
  end

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

end