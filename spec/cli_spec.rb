require 'rspec'
require 'open3'
require 'yaml'

describe 'simple' do

  let(:assets) { File.join(File.dirname(__FILE__), 'assets') }
  let(:command) { "bin/poster -h #{assets}" }
  let(:list_settings) { "bin/poster -l #{assets}" }

  it 'context' do
    # for some reason, the working dir is not the spec dir:
    puts "working dir: #{Dir.pwd}"
    # => ~/Code/Ruby/workspaces/poster
    puts "the assets are at: #{assets}"
  end

  it 'should start and run' do

    # TODO: expect no files

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

    # TODO: expect files

  end

  it 'should render help output to stdout' do
    Open3.popen3(command) do |_stdin, stdout, stderr, wait_thr|
      output = stdout.read

      expect(output).to match /-n, --dry-run/
      expect(output).to match /-v, --verbose/
    end
  end

  it 'should render list of settings to stdout' do
    Open3.popen3(list_settings) do |_stdin, stdout, stderr, wait_thr|
      output = stdout.read
      expect(output).to match /:test=>nil/
    end
  end

  it 'should find and use settings file in working dir' do
    mock_config = File.join(assets, '.poster.rc.yaml')
    File.open(mock_config, 'w') do |f|
      content = { :source_dir => "source", :posts_dir => "_posts", :blogs => { :test => nil }, :default_blog => :test }
      yaml = content.to_yaml
      puts "writing to config: #{yaml}"
      f.write yaml
    end

    Dir.chdir(assets) do

      Open3.popen3(File.join('..', '..', list_settings)) do |_stdin, stdout, stderr, wait_thr|
        output = stdout.read
        err = stderr.read
        expect(output).to match /:test=>nil/
        expect(err).to match /found config in working dir:  true/
        expect(err).to match /wef/
      end
    end
    ensure
    File.delete(mock_config)
  end

end
