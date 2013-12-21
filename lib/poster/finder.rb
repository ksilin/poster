require 'fileutils'
require 'find'

module Poster
  class Finder

    # ends in .md or .markdown
    EXTENSIONS = /^([0-9a-zA-Z_\-\/\.])+([0-9a-zA-Z_])\.m(d|arkdown)$/

    def self.find(dir = FileUtils.getwd)
      Find.find(dir).select { |f|  EXTENSIONS  =~ f }
    end
  end

end