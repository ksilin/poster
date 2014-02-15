require 'find'

module Poster
  class Finder

    # ends in .md or .markdown
    BASENAME = /^([0-9a-zA-Z_\-\/\.])+([0-9a-zA-Z_])\.m(d|arkdown)$/
    EXTENSIONS = /^\.m(d|arkdown)$/
    DATES = /\d{4}_\d{2}_\d{2}/

    def self.find(dir = Dir.pwd, recursive = false)
      Find.find(dir).select { |f|
        if do_not_recurse(dir, f, recursive)
          p "pruning #{f.inspect}"
          Find.prune
        end
        File.file?(f) && has_valid_extension(f) && date_parseable(f)
      }
    end

    def self.has_valid_extension(f)
      puts "matching #{File.extname(f)} with #{EXTENSIONS}"
      EXTENSIONS =~ File.extname(f)
    end

    def self.date_parseable(f)
      basename = File.basename(f, File.extname(f))
      # Date#parse seems no to accept underscores as date delimiters
      replaced_undescores = basename.gsub('_', '-')
      # This is far too lenient. I want dates to be digits only
      # But then I would need to vary delimiters
      # TODO - ask on SO how to make such date parsing with different delimiters
      Date.parse(replaced_undescores) rescue false
    end

    def self.do_not_recurse(dir, file, recursive)
      !recursive && File.directory?(file) && file != dir
    end
  end

end