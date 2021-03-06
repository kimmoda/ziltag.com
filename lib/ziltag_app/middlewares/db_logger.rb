require 'pp'
require 'rack/request'
module ZiltagApp
  module Middlewares
    class DBLogger
      def initialize(app)
        @app = app
      end

      def call(env)
        response = @app.call(env)
        result = LogHTTPRequest.perform(env)
        Rails.logger.error result.error unless result.success?
        response
      rescue
        Rails.logger.error $ERROR_INFO
        Rails.logger.error $ERROR_POSITION.join($RS)
        response
      end
    end
  end
end
