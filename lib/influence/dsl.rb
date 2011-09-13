create_influence do

  message do
    variables(:SSHKEY => 'ssh-dss AAAAB3NzaC1kc3MAAAEBAOWvk9TabSXZlyL8Um1PSrcuvttG9VV5RkJ8dUpuvP4X7kSqbZFw590IU+ZwJrV3SVy1BFW9sZgJK2qKwtQUBOMA6Ivckg3gWrwiX82f4jnnKBMlzJJ+ullla4+9WBP2rw7wP7bH+0fh2a6TUqOOOLM0BgRrOoHHiUT/gmJgWSfRWc/xfjIl2VMm+MmqF21mU+eka1efE9uMh2md0O2iVIYMP4ulbxK4IW6Mo4z3/+Ir9oEgqpLgCmaVCOuQf2NPzS9kKTKAfPZKWiWn/lj66pQ6fa/EDv65BQXkmcrwBKnKlpD2mcRhW+UVJGFmGk1HyRpIVeEIVLg/L9p3K0qSv/sAAAAVANgaqthz26u2wHl5kqHxG4MKwyrJAAABAFgGe+ApgNMJZEQSKmdUQFJ3zO7gonpUOV5zjlDENTOMoC+ViTt9VXUSr6yGcW+OkXyAeUO3A8m9Dbf2LSfq+UPeLxqknIjH4l3HmyoR5H1cl+rq9B1bJsmVzQFRl2719CSXBCpV+25Q+6kPoFZ4JFCzMHMpHjeFJt/KF4NKPwxcz3lvU9gZ1eB+wPUucTdFzAkxtNOsOgk6zxX/hYkS3Ibxbhu3oVfn1joNtY58adnTkn9Xcu3gftS1f+ZDiFfC5aeUKNq3gGnbt3rg4N/46ZIVnsCREz6rkF+aWCJhxBN8jAPi0LCasRbpR5De6JMRVJeW+Dee9dMFsoS2PbdaZRMAAAEABZZmyF6KKhq/lQxy5+8pXGLHzGKwYy6f2VgbJmLvF7qRLLbH0EZbx+PMZ0qwdBZcETTOQKrENhQgjxP+IjuclIU4NfWVlrCfJr2P7pekAQ7YvEn9mP6bXluMNey9Wg+gsiLzPtWYpc2etiIzk3l916DzyL2T05yLZIMRzzGvMvHRZXmOFRuwgUF4APmY8I7Y19zjSRg5zW7SnNiR5VP1bd9Lt4/ibdH03Xyl6Jk2deI0eWCY4auNt0W5ptwG80O6oUP3VWV/GSx5+L29d7jDyQuxQBl8lwuwTWrYt9QD4JwAKWMZ9bwlZt2IXl4YlVRe96JGyFHDI2VjngL7r3oKiA== jdf@FreezeMBP.local')
    sh 'cat $SSHKEY >> /root/.ssh/authorized_keys'
  end

  messages do
    sh 'cat /root/.ssh/id_dsa.pub'
    FileUtils.mkdir_p('root/.ssh')
    append_to_file 'root/.ssh/known_hosts', response.stdout
  end

  messages do
    sh "Update System", 'apt-get update'
    sh "Install VIM",   'apt-get install vim -y'
    sh 'apt-get install libc6-dev -y'
    sh 'apt-get install gcc -y'
    sh 'apt-get install gdb -y'
    sh 'apt-get install libtag1-dev -y'
    sh 'apt-get install uuid-dev -y'
    sh 'apt-get install expat -y'
    sh 'apt-get install libexpat1-dev -y'
    sh 'apt-get install curl -y'
    sh 'apt-get install libcurl4-openssl-dev -y'
    sh 'apt-get install make -y'
    sh 'apt-get install libssl-dev -y' # may already be included from earlier install
    sh 'apt-get install libreadline5 libreadline5-dev -y'
    sh 'apt-get install bison -y'
    sh 'apt-get install screen -y'
    sh 'apt-get --reinstall install perl -y'
    sh 'apt-get --reinstall install perl-modules -y'

    sh 'apt-get install gettext -y'
    sh 'apt-get install bzip2 -y'
    sh 'apt-get install autoconf -y'
    sh 'apt-get install automake -y'

    git = 'git-1.6.2.3'
    sh 'mkdir /c/tmp'
    cd '/c/tmp' do
      sh "wget http://kernel.org/pub/software/scm/git/#{git}.tar.bz2"
      sh "bunzip2 #{git}.tar.bz2"
      sh "tar -xvf #{git}.tar"
      cd git do
        sh 'make prefix=/usr all'
        sh 'make prefix=/usr install'
      end
      sh "rm -rf #{git}*"
    end
  end
  
  message "Create /root/.bash_profile" do
    bash_profile = %Q{
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

set -o vi

alias d='ls -alF'
alias su='su -m'

PATH=$PATH:$HOME/cbd/bin

export PATH
unset USERNAME
}

    screenrc = %Q{
source /etc/screenrc
caption always "%{Yk} %H %0c:%s %{k}|%{G} %l %{k}|%{W} %-w%{+u}%n %t%{-u}%+w"
multiuser on
vbell off
shell -$SHELL
}
    variables { 
      :bash_profile => bash_profile
      :screenrc     => screenrc
    }
    sh 'echo $bash_profile > /root/.bash_profile'
    sh 'echo $screenrc > /root/.screenrc'
  end

end


module Influencer
  
  class Message < Struct.new(:sh, :variables)
  end

  class DSL
    def self.load(dsl_file)
      action = new
      action = action.instance_eval(File.read(dsl_file), dsl_file)
      action
    end
    
    def initialize
    end

    def create_influence_for_bootstrap do
      @bootstrap = true
      yield
    end
    
    def create_influence
      @sh_instances = []
      @messages     = []
      yield
    end
    
    def message
      yield
      run_commands
    end

    def messages
      yield
      run_commands
    end
    
    def sh(cmd)
      @sh_instances << cmd
    end
    
    def variables(vars)
      @variables << vars
    end
    
    def response
      @current_response
    end
    
    def cd(dir)
      @dirs << dir
    end
    
    def ccd(dir)
    end
    
    private
    
    def run_commands
      # setup vars
      @variable_array = []
      @variables.each do |hash|
        hash.each { |var, val| @variable_array << "export #{var}='#{val}'"}
      end
      # set cd
      cmd_array = []
      @dirs.each { |dir| cmd_array << "cd #{dir}" }
    end
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

