class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  respond_to :json

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end
end
