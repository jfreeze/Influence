require 'json'
#require 'message'

module Influence
  class Processor
    def initialize(io)
      @io = io
      loop do
        @message = @io.readline
        process
        respond
      end
    end
    
    private
    
    # run_command => command
    # run_remote_command => url

    def process
#      data = JSON.parse(@message)
      # Log.info @message
    end
    
    def respond
      @io.puts({:result => "COMMAND RECEIVED"}.to_json)
    end
    
  end#Processor
end#module

