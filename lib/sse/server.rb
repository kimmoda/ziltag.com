# frozen_string_literal: true
require 'sse/api'
require 'sse/plugin'

module SSE
  class Server < Goliath::API #:nodoc:
    plugin Plugin

    def on_close(env)
      if env['subscription']
        env.channel.unsubscribe(env['subscription'])
        env.logger.info "client #{env['subscription']} closed."
      end
    end

    def response(env)
      api_response = API.call(env)
      code, headers, _body = api_response
      if headers['Content-Type'] == 'text/event-stream'
        headers.delete 'Content-Length'
        streaming_response(code, headers)
      else
        api_response
      end
    end
  end
end
