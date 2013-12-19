require 'fileutils'
require 'find'

module Poster
  class Finder

    EXTENSIONS = [/^([0-9a-zA-Z_\-\/\.])+([0-9a-zA-Z_]).md$/, /^([0-9a-zA-Z_\-\/\.])+([0-9a-zA-Z_]).markdown$/]

    def self.find(dir = FileUtils.getwd)
      Find.find(dir).select { |f|
        EXTENSIONS.any? { |ext| ext =~ f }
      }
    end
  end

end