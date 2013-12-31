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
        EXTENSIONS  =~ f
      }
    end

    def self.do_not_recurse(dir, f, recursive)
      !recursive && File.directory?(f) && f != dir
    end
  end

end