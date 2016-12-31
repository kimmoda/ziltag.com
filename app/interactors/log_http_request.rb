# frozen_string_literal: true
require 'rack/request'
require 'json'
class LogHTTPRequest < Interactor2 #:nodoc:
  ENV_KEYS = %w(
    REQUEST_METHOD
    SCRIPT_NAME
    PATH_INFO
    QUERY_STRING
    SERVER_NAME
    SERVER_PORT
    rack.version
    rack.url_scheme
  )
  attr_reader :request

  def initialize(env) # rack env
    @env = env
  end

  def perform
    @request = HTTPRequest.create(
      env: @env.select { |k, _| k.start_with?('HTTP_') || ENV_KEYS.include?(k) },
      session_id: @env['rack.session']['session_id'],
      referer: @env['HTTP_REFERER'],
      params: params,
      path: @env['PATH_INFO']
    )
    unless @request.persisted?
      fail! "can't log request: #{@request.errors.full_messages.join(', ')}"
    end
  end

  private

  def params
    request = Rack::Request.new(@env)
    if request.content_type == 'application/json'
      JSON.parse(request.body.read) rescue request.params
    else
      request.params
    end
  end
end
