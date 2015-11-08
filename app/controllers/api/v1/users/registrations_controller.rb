class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
