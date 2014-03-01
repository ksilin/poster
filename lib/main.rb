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

      files = find(dir: options[:source_dir],
                   recursive: options[:recursive],
                   verbose: options[:verbose])

      results = extract(files: files)
      print_summary(results: results)
      $stderr.puts "posting into #{options[:target_name]}" if options[:verbose]

      post(results, options)
    end

    def self.post(results, options)
      results.each_value do |posts|
        Planter.post(posts: posts, target: options[:target_name], opts: options)
      end
    end

    def self.print_summary(results:)
      results.each do |source_file, posts|
        color = posts.empty? ? :red : :green
        $stdout.puts "#{source_file}".colorize(color)
        posts.each do |post|
          $stdout.puts "-> #{post.filename}".colorize(:light_blue)
        end
      end
    end

    def self.extract(files:)
      files.reduce({}) do |sum, f|
        sum[f] = Parser.extract(f)
        sum
      end
    end

    def self.find(dir:, recursive:, verbose:)
      files = Finder.find(dir: dir, recursive: recursive, verbose: verbose)
      $stderr.puts "found #{files.size} file(s) to convert:" if verbose
      files.each { |f| $stderr.puts f } if verbose
      files
    end

    def print_explicit_file_list_warning(files)
      string = "Would work on these files, but ignoring explicit file lists for now: #{files}"
      $stderr.puts string
    end
  end
end
