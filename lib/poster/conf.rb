require 'yaml'

class Conf
  # pwd - expect the config among the notes
  # __FILE__ expect the config inside the gem
  CONFIG_FILENAME = '.poster.rc.yaml'
  # TODO: Dir.pwd - try for the local file first, then the packaged one
  CONFIG_FILE = File.join(File.join(File.dirname(__FILE__), '..', '..'), CONFIG_FILENAME)

  def initialize(config_file = CONFIG_FILE)
    user_config = File.join(Dir.home, CONFIG_FILENAME)
    $stderr.puts "found config in home dir:  #{File.exist? user_config} : #{user_config}"
    folder_config = File.join(Dir.pwd, CONFIG_FILENAME)
    $stderr.puts "found config in working dir:  #{File.exist? folder_config} : #{folder_config}"

    if File.exist? config_file
      @config_options = YAML.load_file(config_file)
      $stderr.puts "loaded #{config_file}, #{@config_options}"
      # options.merge!(config_options)
    else
      warn "configuration not found in #{config_file}"
    end
  end

  def [](index)
    @config_options[index]
  end

  def []=(index, value)
    @config_options[index] = value
  end
end
