require 'rspec'
require 'open3'

describe 'simple' do

  it 'should start and run' do

    # TODO expect no files

    Open3.popen3('bin/poster') { |stdin, stdout, stderr, wait_thr|
      pid = wait_thr.pid # pid of the started process.
      exit_status = wait_thr.value # Process::Status object returned.

      p stdin
      p stdout
      p stderr

      puts "stdout is:" + stdout.read
      puts "stderr is:" + stderr.read

    }

    #p system('bin/poster')

    # TODO capture and eval help output

    # TODO expect files

  end
end