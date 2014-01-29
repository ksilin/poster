require 'find'

module Poster
  class Finder

    # ends in .md or .markdown
    EXTENSIONS = /^([0-9a-zA-Z_\-\/\.])+([0-9a-zA-Z_])\.m(d|arkdown)$/

    def self.find(dir = Dir.pwd, recursive = false)
      Find.find(dir).select { |f|
        if do_not_recurse(dir, f, recursive)
          p "pruning #{f.inspect}"
          Find.prune
        end
        has_valid_extension(f) && date_parseable(File.basename(f))
      }
    end

    def self.has_valid_extension(f)
      EXTENSIONS =~ f
    end

    def self.date_parseable(f)
      Date.parse(f) rescue false
    end

    def self.do_not_recurse(dir, file, recursive)
      !recursive && File.directory?(file) && file != dir
    end
  end

end