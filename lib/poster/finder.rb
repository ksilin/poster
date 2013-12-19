require 'fileutils'
require 'find'

module Poster
  class Finder

    EXTENSIONS = [/.md/, /.markdown/]

    def self.find(dir = FileUtils.getwd)
      Find.find(dir).select { |f|
        EXTENSIONS.any? { |ext| ext =~ f }
      }
    end
  end

end