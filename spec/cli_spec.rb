require 'rspec'
require 'open3'

describe 'simple' do

  it 'should start and run' do

    # TODO: expect no files

    command = 'bin/poster -h ~/Desktop/md/done'
    Open3.popen3(command) do |_stdin, stdout, stderr, wait_thr|
      pid = wait_thr.pid # pid of the started process.
      exit_status = wait_thr.value # Process::Status object returned.

      p "pid: #{pid}"
      p "exit status: #{exit_status}"

      puts 'stdout: --------------------------'
      puts stdout.read
      puts ' * * * '
      puts 'stderr: --------------------------'
      puts stderr.read
      puts ' * * * '
      # puts 'stdin: --------------------------'
      # puts stdin.read
    end

    # p system('bin/poster')

    # TODO: capture and eval help output

    # TODO: expect files

  end
end
