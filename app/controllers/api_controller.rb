class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  before_action :authenticate_user!, only: %i[create update destroy]

  def options
    head 200
  end

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end

end
