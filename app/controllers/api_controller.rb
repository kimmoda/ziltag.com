# frozen_string_literal: true
class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_headers
  skip_after_action :enable_iframe

  rescue_from Exception do |exception|
    error_id = SecureRandom.hex
    Rails.logger.error error_id
    Rails.logger.error exception.to_s
    Rails.logger.error exception.backtrace.join($INPUT_RECORD_SEPARATOR)
    render json: { error: "something went wrong, error id: #{error_id}" }, status: 200
  end

  def options
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = '1728000'
    head 200
  end

  private

  def set_headers
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  end
end
