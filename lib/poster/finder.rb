require 'find'
require_relative 'validator'

module Poster
  class Finder

    def self.find(dir = Dir.pwd, opts = {})
      opts = { recursive: false, verbose: false }.merge(opts)

      Find.find(dir).select { |f|
        prune(dir, f, opts)
        valid_post_file?(f)
      }
    end

    def self.valid_post_file?(f)
      File.file?(f) && Validator.valid_post_filename?(f)
    end

    def self.prune(dir, f, opts)
      if do_not_recurse(dir, f, opts[:recursive])
        $stderr.puts "pruning #{f.inspect}" if opts[:verbose]
        Find.prune
      end
    end

    def self.do_not_recurse(dir, file, recursive)
      !recursive && File.directory?(file) && file != dir
    end
  end

end