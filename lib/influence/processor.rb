require 'json'
#require 'message'

module Influence
  class Processor
    def initialize(io)
      Log.info "Processor.new"
      @io = io
      while @message = @io.readline
        Log.info "read: #{@message}"
        process
        respond
      end
      # @io.close
      # loop do
      #   begin
      #     @message = @io.readlines
      #     # Log.info "Transmitted Data Size: #{@message.size}"
      #     # Log.info "Transmitted Data: #{@message}"
      #     process
      #     respond
      #   rescue EOFError
      #     Log.info "End of the line"
      #   end
      # end
    end
    
    private
    
    # run_command => command
    # run_remote_command => url

    def process
     data = JSON.parse(@message)
     Log.info data.ai
    end
    
    def respond
      @io.puts({:result => "COMMAND RECEIVED"}.to_json)
    end
    
  end#Processor
end#module
