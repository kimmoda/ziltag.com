require 'eventmachine'
require 'logger'

DB_CONN = ActiveRecord::Base.connection_pool.checkout.raw_connection # TODO: replace with sequel
%w[create update delete].product(%w[ziltag comment]).each do |action, resource|
  DB_CONN.exec "LISTEN #{action}_#{resource}"
end

class PushServer < EM::Connection
  SSL_KEY = Rails.env.development? ? "#{__dir__}/../config/ssl/localhost.key" : ENV['SSL_KEY']
  SSL_CERT = Rails.env.development? ? "#{__dir__}/../config/ssl/localhost.crt" : ENV['SSL_CERT']
  LOGGER = Logger.new(ENV['LOG_PATH'] || STDOUT)
  ERROR_LOGGER = Logger.new(ENV['ERROR_LOG_PATH'] || STDERR)

  @@clients = {}

  attr_reader :slug

  def broadcast slugs, event, data
    Array(slugs).each do |slug|
      Array(@@clients[slug]).each do |client|
        client.send_data "event: #{event}\ndata: #{data.to_json}\n\n"
      end
    end
  end

  def post_init
    start_tls(private_key_file: SSL_KEY, cert_chain_file: SSL_CERT, verify_peer: false)
    @buffer = ''
    LOGGER.info "#{self} connected"
  end

  def notify_readable
    DB_CONN.consume_input
    while notification = DB_CONN.notifies
      event, pid, payload = notification[:relname], notification[:be_pid], notification[:extra]
      action, underscore = event.split('_')
      data = JSON.parse(payload)
      slug = data.delete('slug')
      broadcast(slug, event, data)
    end
  end

  def receive_data data
    @buffer << data
    if @buffer.length > 43
      if @buffer =~ %r{^GET /api/v1/ziltags/(\w{6})/stream HTTP/1.1}
        DB_CONN.async_exec(Ziltag.where(slug: $1).limit(1).to_sql) do |result|
          if result.values.empty?
            send_data "HTTP/1.1 404 Not Found\nServer: Ziltag Push Server\n\n"
            close_connection_after_writing
          else
            @slug = $1
            @@clients[@slug] ||= []
            @@clients[@slug] << self
            send_data "HTTP/1.1 200 OK
Server: Ziltag Push Server
Content-Type: text/event-stream
Connection: Keep-Alive
Access-Control-Allow-Origin: *\n\n"
          end
        end
      else
        send_data "HTTP/1.1 404 Not Found\nServer: Ziltag Push Server\n\n"
        close_connection_after_writing
      end
    end
  end

  def unbind
    if @@clients[@slug]
      @@clients[@slug].delete(self)
      @@clients.delete @slug if @@clients[@slug].empty?
    end
    LOGGER.info "#{self} disconnected"
  end
end

EM.epoll
EM.run do
  EM.watch(DB_CONN.socket_io, PushServer).notify_readable = true
  EM.start_server '0.0.0.0', 3310, PushServer
end