class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json
end
