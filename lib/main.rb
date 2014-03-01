require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'
require 'poster/post'
require 'poster/conf'

require 'colorize'

module Poster
  module Main
    DEFAULT_OPTIONS = {
        target_name: :test,
        verbose: false,
        source_dir: Dir.pwd,
        recursive: false,
        overwrite: true,
        dry_run: false,
        files: nil
    }

    # TODO: control overwriting the target
    # TODO: use .erb template
    # TODO: complete code block syntax in posts using either a default language or CL param

    def self.convert(opts = {})
      options = DEFAULT_OPTIONS.merge(opts)

      print_explicit_file_list_warning(options[:files]) if options[:files]

      files = find(options)
      results = extract(files, options[:verbose])
      print_summary(results, options)
      results.each do |_file, post|
        Planter.post(post, options[:target_name], options)
      end
    end

    def self.print_summary(results, options = {})
      results.each do |source_file, posts|
        color = posts.empty? ? :red : :green
        $stdout.puts "#{source_file}".colorize(color)
        posts.each do |post|
          $stdout.puts "-> #{post.filename}".colorize(:light_blue)
        end
      end
      $stderr.puts "posting into #{options[:target_name]}" if options[:verbose]
    end

    def self.extract(files, verbose)
      files.inject({}) do |sum, f|
        extracted = Parser.extract(f)
        sum[f] = extracted
        $stderr.puts "extracted #{extracted.size} posts from #{f}" if verbose
        sum
      end
    end

    def self.find(options)
      files = Finder.find(options[:source_dir], options)
      $stderr.puts "found #{files.size} file(s) to convert:" if options[:verbose]
      files.each { |f| $stderr.puts f } if options[:verbose]
      files
    end

    def print_explicit_file_list_warning(files)
      string = "Would work on these files, but ignoring explicit file lists for now: #{files}"
      $stderr.puts string
    end
  end
end
