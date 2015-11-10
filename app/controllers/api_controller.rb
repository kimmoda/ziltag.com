class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  skip_after_action :enable_iframe

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

end
