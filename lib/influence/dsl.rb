module Influencer
  class DSL
    def self.load(file)
    end

    def initialize
      @current_message
    end

    def message
      @current_message = ??
      @shell_command = ""
      yield
      convert_to_json
      send
    end
    
    def shell_command(cmd)
      @shell_command = cmd
    end
    
    def variables(vars)
      @variables = vars
    end
    
    def response
      @current_response
    end
    
    private
    
    def convert_to_json
      process_message
      @message = { :shell_command => @command }.to_json
    end
    
    def process_message
      praocess_variables
      @message = [@json_variables, @shell_command].join('; ')
    end
    
    def praocess_variables
      vars = []
      @variables.each do |name, val|
        vars = "export #{name}='#{val}'"
      end
      @json_variables = vars.join('; ')
    end
  end
end

module Influencer::DSL
  message do
    shell_command 'cat $SSHKEY >> /root/.ssh/authorized_k'
    variables(:SSHKEY => 'ssh-dss AAAAB3NzaC1kc3MAAAEBAOWvk9TabSXZlyL8Um1PSrcuvttG9VV5RkJ8dUpuvP4X7kSqbZFw590IU+ZwJrV3SVy1BFW9sZgJK2qKwtQUBOMA6Ivckg3gWrwiX82f4jnnKBMlzJJ+ullla4+9WBP2rw7wP7bH+0fh2a6TUqOOOLM0BgRrOoHHiUT/gmJgWSfRWc/xfjIl2VMm+MmqF21mU+eka1efE9uMh2md0O2iVIYMP4ulbxK4IW6Mo4z3/+Ir9oEgqpLgCmaVCOuQf2NPzS9kKTKAfPZKWiWn/lj66pQ6fa/EDv65BQXkmcrwBKnKlpD2mcRhW+UVJGFmGk1HyRpIVeEIVLg/L9p3K0qSv/sAAAAVANgaqthz26u2wHl5kqHxG4MKwyrJAAABAFgGe+ApgNMJZEQSKmdUQFJ3zO7gonpUOV5zjlDENTOMoC+ViTt9VXUSr6yGcW+OkXyAeUO3A8m9Dbf2LSfq+UPeLxqknIjH4l3HmyoR5H1cl+rq9B1bJsmVzQFRl2719CSXBCpV+25Q+6kPoFZ4JFCzMHMpHjeFJt/KF4NKPwxcz3lvU9gZ1eB+wPUucTdFzAkxtNOsOgk6zxX/hYkS3Ibxbhu3oVfn1joNtY58adnTkn9Xcu3gftS1f+ZDiFfC5aeUKNq3gGnbt3rg4N/46ZIVnsCREz6rkF+aWCJhxBN8jAPi0LCasRbpR5De6JMRVJeW+Dee9dMFsoS2PbdaZRMAAAEABZZmyF6KKhq/lQxy5+8pXGLHzGKwYy6f2VgbJmLvF7qRLLbH0EZbx+PMZ0qwdBZcETTOQKrENhQgjxP+IjuclIU4NfWVlrCfJr2P7pekAQ7YvEn9mP6bXluMNey9Wg+gsiLzPtWYpc2etiIzk3l916DzyL2T05yLZIMRzzGvMvHRZXmOFRuwgUF4APmY8I7Y19zjSRg5zW7SnNiR5VP1bd9Lt4/ibdH03Xyl6Jk2deI0eWCY4auNt0W5ptwG80O6oUP3VWV/GSx5+L29d7jDyQuxQBl8lwuwTWrYt9QD4JwAKWMZ9bwlZt2IXl4YlVRe96JGyFHDI2VjngL7r3oKiA== jdf@FreezeMBP.local')
  end
  puts response
  
  { 'shell_command' : 'cat $SSHKEY >> /root/.ssh/authorized_k',
    'variables' : {
      'SSHKEY' : 'ssh-dss AAAAB3NzaC1kc3MAAAEBAOWvk9TabSXZlyL8Um1PSrcuvttG9VV5RkJ8dUpuvP4X7kSqbZFw590IU+ZwJrV3SVy1BFW9sZgJK2qKwtQUBOMA6Ivckg3gWrwiX82f4jnnKBMlzJJ+ullla4+9WBP2rw7wP7bH+0fh2a6TUqOOOLM0BgRrOoHHiUT/gmJgWSfRWc/xfjIl2VMm+MmqF21mU+eka1efE9uMh2md0O2iVIYMP4ulbxK4IW6Mo4z3/+Ir9oEgqpLgCmaVCOuQf2NPzS9kKTKAfPZKWiWn/lj66pQ6fa/EDv65BQXkmcrwBKnKlpD2mcRhW+UVJGFmGk1HyRpIVeEIVLg/L9p3K0qSv/sAAAAVANgaqthz26u2wHl5kqHxG4MKwyrJAAABAFgGe+ApgNMJZEQSKmdUQFJ3zO7gonpUOV5zjlDENTOMoC+ViTt9VXUSr6yGcW+OkXyAeUO3A8m9Dbf2LSfq+UPeLxqknIjH4l3HmyoR5H1cl+rq9B1bJsmVzQFRl2719CSXBCpV+25Q+6kPoFZ4JFCzMHMpHjeFJt/KF4NKPwxcz3lvU9gZ1eB+wPUucTdFzAkxtNOsOgk6zxX/hYkS3Ibxbhu3oVfn1joNtY58adnTkn9Xcu3gftS1f+ZDiFfC5aeUKNq3gGnbt3rg4N/46ZIVnsCREz6rkF+aWCJhxBN8jAPi0LCasRbpR5De6JMRVJeW+Dee9dMFsoS2PbdaZRMAAAEABZZmyF6KKhq/lQxy5+8pXGLHzGKwYy6f2VgbJmLvF7qRLLbH0EZbx+PMZ0qwdBZcETTOQKrENhQgjxP+IjuclIU4NfWVlrCfJr2P7pekAQ7YvEn9mP6bXluMNey9Wg+gsiLzPtWYpc2etiIzk3l916DzyL2T05yLZIMRzzGvMvHRZXmOFRuwgUF4APmY8I7Y19zjSRg5zW7SnNiR5VP1bd9Lt4/ibdH03Xyl6Jk2deI0eWCY4auNt0W5ptwG80O6oUP3VWV/GSx5+L29d7jDyQuxQBl8lwuwTWrYt9QD4JwAKWMZ9bwlZt2IXl4YlVRe96JGyFHDI2VjngL7r3oKiA== jdf@FreezeMBP.local'
    }
  }
  
  message do
    shell_command 'cat /root/.ssh/id_dsa.pub'
  end
  `cat #{response.shell_command} >> /root/.ssh/known_hosts`
  
  { 'shell_command' : 'cat /root/.ssh/id_dsa.pub' }
  # response
  { 'output' : 
    'result_code' :
    'received_at' :
    'responded_at' :
  }
  Text     :log
