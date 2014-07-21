require 'rspec'
require 'open3'
require 'yaml'

shared_context 'FS setup' do

  let(:assets) { File.join(File.dirname(__FILE__), 'assets') }
  let(:executable) { File.join(File.dirname(__FILE__), '..', 'bin', 'poster') }
end

describe 'context - where are we?' do
  include_context 'FS setup'

  it 'working dir of this spec should be the poster directory, not spec' do
    wd = Dir.pwd
    puts "working dir: #{wd}"
    expect(wd).to end_with 'poster'
  end

  it 'assets dir should contain md files' do
    FileUtils.cd(assets) do
      puts "found md files: #{Dir['*.md']}"
      expect(Dir['*.md']).not_to be_empty
    end
  end


end

describe 'execution flags' do
  include_context 'FS setup'

  let(:help) { executable + " -h #{assets}" }
  let(:list_settings) { executable + " -l #{assets}" }

  it 'should start and run - a smoke test' do

    Open3.popen3(help) do |_stdin, stdout, stderr, wait_thr|
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
  end

  it 'should render help output to stdout' do
    Open3.popen3(help) do |_stdin, stdout, stderr, wait_thr|
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
    begin

      mock_config = File.join(assets, '.poster.rc.yaml')
      File.open(mock_config, 'w') do |f|
        content = { :source_dir => 'source', :posts_dir => '_posts', :blogs => { :test => nil }, :default_blog => :test }
        yaml = content.to_yaml
        puts "writing to config: #{yaml}"
        f.write yaml
      end

      Dir.chdir(assets) do

        Open3.popen3(list_settings) do |_stdin, stdout, stderr, wait_thr|
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

end
