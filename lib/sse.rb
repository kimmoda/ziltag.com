require_relative '../config/environment'
Bundler.require(:sse)
require_relative './sse/app'
require_relative './sse/backend'
require_relative './sse/notify_handler'

EM.epoll
EM.run do
  app = SSE::App.new
  EM.watch(NotifyHandler::DB_CONN.socket_io, NotifyHandler, app).notify_readable = true
  Rack::Server.start(
    app: app,
    server: 'thin',
    signals: false,
    Host: '127.0.0.1',
    Port: 3310,
    backend: SSE::Backend
  )
end