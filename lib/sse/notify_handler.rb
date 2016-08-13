# frozen_string_literal: true
require 'em/connection'
require 'active_record/base'

module SSE
  class NotifyHandler < EM::Connection #:nodoc:
    DB_CONN = ActiveRecord::Base.connection_pool.checkout.raw_connection
    DB_CONN.exec 'LISTEN notification'

    def initialize(channel)
      super
      @channel = channel
    end

    def notify_readable
      DB_CONN.consume_input
      notification = DB_CONN.notifies
      if notification
        sse_notification_id = notification[:extra]
        @channel.push(SseNotification.find(sse_notification_id).body)
      end
    rescue ActiveRecord::RecordNotFound
      $stderr.puts "SseNotifications #{sse_notification_id} not found"
    end
  end
end
