# frozen_string_literal: true
require 'sse/notify_handler'
module SSE
  class Plugin
    def initialize(address, port, config, status, logger)
      @channel = config['channel']
    end

    def run
      EM.watch(NotifyHandler::DB_CONN.socket_io, NotifyHandler, @channel)
        .notify_readable = true
    end
  end
end
