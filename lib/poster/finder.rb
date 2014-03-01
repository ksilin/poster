require 'find'
require_relative 'validator'

module Poster
  module Finder
    def self.find(dir: Dir.pwd, recursive: false, verbose: false )
      $stderr.puts "working in : #{dir}" if verbose

      Find.find(dir).select do |f|
        prune(dir, f, recursive)
        valid?(f)
      end
    end

    def self.prune(dir, f, recursive = false)
      Find.prune if do_not_traverse(dir, f, recursive)
    end

    def self.valid?(f)
      File.file?(f) && Validator.valid_post_filename?(f)
    end

    def self.do_not_traverse(dir, file, recursive = false)
      !recursive && File.directory?(file) && file != dir
    end
  end
end
