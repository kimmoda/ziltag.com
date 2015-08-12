class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  before_action :authenticate_user!, only: %i[create update destroy]

  def options
    head 200
  end

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || 'http://localhost:3000'
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, Content-Type'
  end

end
