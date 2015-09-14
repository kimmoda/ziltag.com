class ApiController < ApplicationController
  before_action :set_headers

private

  def set_headers
    headers['Access-Control-Allow-Origin'] = '*'
  end

end
