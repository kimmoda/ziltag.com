require 'thin/backends/tcp_server'

module SSE
  class Backend < Thin::Backends::TcpServer
    SSL_KEY = ENV['SSL_KEY'] || "#{__dir__}/../../config/ssl/localhost.key"
    SSL_CERT = ENV['SSL_CERT'] || "#{__dir__}/../../config/ssl/localhost.crt"

    def initialize host, port, options
      super(host, port)
      @ssl = ENV['SSL_KEY'] && ENV['SSL_CERT']
      @ssl_options = {private_key_file: SSL_KEY, cert_chain_file: SSL_CERT, verify_peer: false}
    end
  end
end
