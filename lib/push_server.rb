require 'socket'

ARGV[0] ||= '0.0.0.0'
ARGV[1] ||= 3310

DB_CONN = PG.connect dbname: 'ziltag_development'
DB_SOCKET = DB_CONN.socket_io
SERVER_SOCKET = TCPServer.new *ARGV
SOCKETS = [SERVER_SOCKET, DB_SOCKET]

%w[create update delete].product(%w[ziltag comment]).each do |action, resource|
  DB_CONN.exec "LISTEN #{action}_#{resource}"
end

def broadcast message
  SOCKETS.each do |socket|
    if socket != SERVER_SOCKET && socket != DB_SOCKET
      socket.send(message, 0)
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
      client_socket.send "HTTP/1.1 200 OK
Server: Ziltag Push Server
Content-Type: text/event-stream
Connection: keep-alive
Access-Control-Allow-Origin: *\n\n", 0
    when DB_SOCKET
      DB_CONN.consume_input
      while notification = DB_CONN.notifies
        event, pid, payload = notification[:relname], notification[:be_pid], notification[:extra]
        action, underscore = event.split('_')
        record = underscore.classify.constantize.find(payload)
        broadcast "event: #{event}\ndata: #{record.as_json}\n\n"
      end
    else
      msg = socket.recv(1024)
      if msg.empty?
        SOCKETS.delete(socket)
        puts "OFFLINE: #{socket}"
      else
        puts "RECEIVE: #{msg.inspect} from #{socket}"
      end
    end
  end
end