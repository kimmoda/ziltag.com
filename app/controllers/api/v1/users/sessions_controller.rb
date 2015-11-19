class Api::V1::Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  respond_to :json

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end
end
