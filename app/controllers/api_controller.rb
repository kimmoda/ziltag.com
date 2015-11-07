class ApiController < ApplicationController
  before_action :set_headers
  skip_after_action :enable_iframe

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

end
