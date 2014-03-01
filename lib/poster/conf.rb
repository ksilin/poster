require 'yaml'

class Conf
  # TODO should it be pwd or __FILE__ ?
  # pwd - expect the config among the notes
  # __FILE__ expect the config inside the gem
  CONFIG_FILENAME = '.poster.rc.yaml'
  CONFIG_FILE = File.join(Dir.pwd, CONFIG_FILENAME)

  def initialize
    if File.exists? CONFIG_FILE
      @config_options = YAML.load_file(CONFIG_FILE)
      # options.merge!(config_options)
    end
  end

  def [](index)
    @config_options[index]
  end

  def []=(index, value)
    @config_options[index] = value
  end
end
