require 'eventmachine'

DB_CONN = ActiveRecord::Base.connection_pool.checkout.raw_connection
DB_SOCKET = DB_CONN.socket_io

%w[create update delete].product(%w[ziltag comment]).each do |action, resource|
  DB_CONN.exec "LISTEN #{action}_#{resource}"
end

class PushServer < EM::Connection
  @@clients = []
  @@slug_map_clients = {}

  attr_reader :slug

  def broadcast msg, slugs
    Array(slugs).each do |slug|
      Array(@@slug_map_clients[slug]).each do |client|
        client.send_data msg
      end
    end
  end

  def post_init
    puts "#{self} connected"
  end

  def notify_readable
    DB_CONN.consume_input
    buf = ''
    while notification = DB_CONN.notifies
      event, pid, payload = notification[:relname], notification[:be_pid], notification[:extra]
      action, underscore = event.split('_')
      klass = underscore.classify.constantize
      DB_CONN.async_exec(klass.where(id: payload).limit(1).to_sql) do |result|
        record = klass.new klass.column_names.zip(result.values.first).to_h
        buf << "event: #{event}\ndata: "
        case record
        when Ziltag
          DB_CONN.async_exec(Ziltag.select(:slug).where(photo_id: record.photo_id).to_sql) do |result|
            slug = result.values.flatten
            buf << {
              slug: record.slug, x: record.x, y: record.y, content: record.content,
              username: record.username, avatar: record.user.avatar.thumb.url,
              confirmed: record.confirmed?
            }.to_json
            buf << "\n\n"
            broadcast buf, slug
          end
        when Comment
          DB_CONN.async_exec(Ziltag.select(:slug).where(id: record.ziltag_id).limit(1).to_sql) do |result|
            slug = result.values.first.first
            buf << {
              id: record.id, content: record.content,
              username: record.username, avatar: record.user.avatar.thumb.url,
              confirmed: record.confirmed?
            }.to_json
            buf << "\n\n"
            broadcast buf, slug
          end
        end
      end
    end
  end

  def receive_data data
    if data =~ %r{GET /api/v1/ziltags/(\w{6})/stream HTTP/1.1}
      DB_CONN.async_exec(Ziltag.where(slug: $1).limit(1).to_sql) do |result|
        if result.values.empty?
          send_data "HTTP/1.1 404 Not Found\nServer: Ziltag Push Server\n\n"
          close_connection_after_writing
        else
          @slug = $1
          @@clients << self
          @@slug_map_clients[@slug] ||= []
          @@slug_map_clients[@slug] << self
          send_data "HTTP/1.1 200 OK
  Server: Ziltag Push Server
  Content-Type: text/event-stream
  Connection: keep-alive
  Access-Control-Allow-Origin: *\n\n"
        end
      end
    else
      send_data "HTTP/1.1 404 Not Found\nServer: Ziltag Push Server\n\n"
      close_connection_after_writing
    end
  end

  def unbind
    @@clients.delete(self)
    if @@slug_map_clients[@slug]
      @@slug_map_clients[@slug].delete(self)
      @@slug_map_clients.delete @slug if @@slug_map_clients[@slug].empty?
    end
    puts "#{self} disconnected"
  end
end

EventMachine.run do
  conn = EventMachine.watch DB_SOCKET, PushServer
  conn.notify_readable = true
  EventMachine.start_server '0.0.0.0', 3310, PushServer
end