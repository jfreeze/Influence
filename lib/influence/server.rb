require 'gserver'

module Influence

  class Server < GServer
    DEFAULT_PORT = 4321
    
    def initialize(port=DEFAULT_PORT, *args)
      super
    end
    
    def self.launch
      @server       = new
      @server.audit = true
      @server.start
      @server.join
    end

    def serve(io)
      Processor.new(io)
    end

    private

    def starting
      puts "Starting Influence Server (#{Process.id})..."
      true
    end
    def connecting( tcp_socket )
      puts " - Before serve #{tcp_socket}"
  #    p tcp_socket.methods
      # puts tcp_socket.getsockname
      puts tcp_socket.peeraddr
      puts tcp_socket.addr
      # puts tcp_socket.count
      true
    end
    def disconnecting( client_port )
      puts " - After serve #{client_port}"
      true
    end
    def stopping
      puts " - Server shuts down"
      true
    end
  end#end Class
end#end module
