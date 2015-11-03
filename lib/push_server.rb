require 'socket'
require 'uri'

BIND_URI = URI(ARGV.shift || 'tcp://localhost:3310')
SERVER_SOCKET = case BIND_URI.scheme
                when 'tcp'
                  TCPServer.new BIND_URI.host, BIND_URI.port
                when 'unix'
                  UNIXServer.new BIND_URI.path
                end
DB_CONN = PG.connect dbname: 'ziltag_development'
DB_SOCKET = DB_CONN.socket_io
SOCKETS = [SERVER_SOCKET, DB_SOCKET]
SLUG_MAP_SOCKETS = {}


%w[create update delete].product(%w[ziltag comment]).each do |action, resource|
  DB_CONN.exec "LISTEN #{action}_#{resource}"
end

def broadcast message, slugs=[]
  Array(slugs).each do |slug|
    Array(SLUG_MAP_SOCKETS[slug]).each do |socket|
      if socket != SERVER_SOCKET && socket != DB_SOCKET
        begin
          socket.send(message, 0)
        rescue
          $stderr.puts $!, $@
          socket.close
          SOCKETS.delete socket
          SLUG_MAP_SOCKETS[slug].delete socket
          SLUG_MAP_SOCKETS.delete slug if SLUG_MAP_SOCKETS[slug].empty?
        end
      end
    end
  end

end

loop do
  ready_to_read, ready_to_write, in_error = select(SOCKETS, [], [])

  ready_to_read.each do |socket|
    case socket
    when SERVER_SOCKET
      client_socket, client_addrinfo = SERVER_SOCKET.accept
      puts "ONLINE: #{client_socket}"
      SOCKETS << client_socket
    when DB_SOCKET
      DB_CONN.consume_input
      buf = ''
      while notification = DB_CONN.notifies
        event, pid, payload = notification[:relname], notification[:be_pid], notification[:extra]
        action, underscore = event.split('_')
        record = underscore.classify.constantize.find(payload)
        buf << "event: #{event}\ndata: "
        case record
        when Ziltag
          slug = record.photo.ziltags.pluck(:slug)
          buf << {
            slug: record.slug, x: record.x, y: record.y, content: record.content,
            username: record.username, avatar: record.user.avatar.thumb.url,
            confirmed: record.confirmed?
          }.to_json
        when Comment
          slug = record.ziltag.slug
          buf << {
            id: record.id, content: record.content,
            username: record.username, avatar: record.user.avatar.thumb.url,
            confirmed: record.confirmed?
          }.to_json
        end
        buf << "\n\n"
      end
      broadcast buf, slug
    else
      msg = socket.recv(2048)
      if msg.empty?
        SOCKETS.delete(socket)
        puts "OFFLINE: #{socket}"
      elsif msg !~ %r{GET /api/v1/ziltags/(\w{6})/stream HTTP/1.1} || !Ziltag.exists?(slug: $1)
        socket.send "HTTP/1.1 404 Not Found
Server: Ziltag Push Server\n\n", 0
        socket.close
        SOCKETS.delete(socket)
      else
        SLUG_MAP_SOCKETS[$1] ||= []
        SLUG_MAP_SOCKETS[$1] << socket
        socket.send "HTTP/1.1 200 OK
Server: Ziltag Push Server
Content-Type: text/event-stream
Connection: keep-alive
Access-Control-Allow-Origin: *\n\n", 0
      end
    end
  end
end