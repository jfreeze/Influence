require 'gserver'

class EchoServer < GServer
  def initialize(port=4321, *args)
    super
  end
  def serve(io)
    line = io.readline
    io.puts( line )
  end
end

es = EchoServer.new
es.start
es.join
#
# A server that returns the time in seconds since 1970.
#
class TimeServer < GServer
  def initialize(port=10001, *args)
    super(port, *args)
  end
  def serve(io)
    c = rand(10)
    p c
    if c < 5
      x = Time.now.to_s
      puts x
      io.puts(x)
    else
      puts "Hello"
      io.puts("Hello")
    end
  ensure
    io.puts "\n\n"
  end
  
  def starting
    puts" – Server starts up"
    true
  end
  def connecting( tcp_socket )
    puts " – Before serve #{tcp_socket}"
#    p tcp_socket.methods
    puts tcp_socket.getsockname
    puts tcp_socket.peeraddr
    puts tcp_socket.addr
    # puts tcp_socket.count
    true
  end
  def disconnecting( client_port )
    puts " – After serve #{client_port}"
    true
  end
  def stopping
    puts " – Server shuts down"
    true
  end
  
end

class HelloServer < GServer
  def initialize(port=1234, *args)
    super(port, *args)
  end
  def serve(io)
    io.puts("Hello")
    # io.flush
  end
end

# Run the server with logging enabled (it's a separate thread).
server = TimeServer.new
server.audit = true                  # Turn logging on.
server.start


hserver = HelloServer.new
hserver.audit = true
hserver.start

hserver.join
server.join
