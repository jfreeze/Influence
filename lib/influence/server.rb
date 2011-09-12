require 'gserver'
require 'logger'

module Influence
  class Server < GServer
    Log = Logger.new(File.join(File.dirname(__FILE__), "..", "..", "bin", 'influence.log'), 5, 1024000)

    def initialize(port, options = {})
      @port    = port
      @options = options
      super(port, options[:host] || Influence::DEFAULT_HOST)
    end

    def self.launch(options={})
      @server = new(options[:port] || Influence::DEFAULT_PORT)
      @server.audit = true
      @server.start
      @server.join
    end

    def serve(io)
      Processor.new(io)
    end

    private

    def starting
      Log.info "Starting Influence Server (#{Process.pid})..."
      true
    end
    
    def connecting( tcp_socket )
      Log.info " - Before serve #{tcp_socket}"
  #    p tcp_socket.methods
      # puts tcp_socket.getsockname
      puts tcp_socket.peeraddr
      puts tcp_socket.addr
      # puts tcp_socket.count
      true
    end
    def disconnecting( client_port )
      Log.info " - After serve #{client_port}"
      true
    end
    def stopping
      puts "Influence Server shutting down (#{Process.pid})..."
      true
    end
  end#end Class
end#end module
