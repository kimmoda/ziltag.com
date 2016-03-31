require 'em/connection'
require 'active_record/base'

class NotifyHandler < EM::Connection
  DB_CONN = ActiveRecord::Base.connection_pool.checkout.raw_connection

  %w[create update delete].product(%w[ziltag comment]).each do |action, resource|
    DB_CONN.exec "LISTEN #{action}_#{resource}"
  end

  def initialize app
    super
    @app = app
  end

  def notify_readable
    DB_CONN.consume_input
    while notification = DB_CONN.notifies
      event, pid, payload = notification[:relname], notification[:be_pid], notification[:extra]
      action, resource = event.split('_')
      data = JSON.parse(payload)
      slug = data.delete('_slug')
      map_id = data.delete('_map_id') if resource == 'ziltag'
      @app.helpers.broadcast_zilag(slug, event, data)
      @app.helpers.broadcast_map(map_id, event, data)
    end
  end
end