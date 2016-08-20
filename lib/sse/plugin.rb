# frozen_string_literal: true
require 'sse/notify_handler'
module SSE
  class Plugin
    def initialize(_address, _port, config, _status, _logger)
      @channel = config['channel']
    end

    def run
      EM.watch(NotifyHandler::DB_CONN.socket_io, NotifyHandler, @channel)
        .notify_readable = true
    end
  end
end
