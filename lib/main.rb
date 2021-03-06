require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'
require 'poster/post'
require 'poster/conf'

require 'colorize'
require 'readline'

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

    # TODO: test for overwriting control
    # TODO: use .erb template
    # TODO: complete code block syntax in posts
    # using either a default language or CL param

    def self.convert(opts = {})
      options = DEFAULT_OPTIONS.merge(opts)

      print_explicit_file_list_warning(options[:files]) if options[:files]

      files = find(dir: options[:source_dir],
                   recursive: options[:recursive],
                   verbose: options[:verbose])

      print_found_files(files) if options[:verbose]
      #files.each { |file|
      #    if options[:interactive]
      #      read = nil
      #      until %w(Y y N n A a).any? {|char| char == read}
      #        read = Readline.readline("post? [Y(es)|n(ext)|a(bort)]> ")
      #      end
      #      puts read
      #    end
      #}
      #end

      results = extract(files, options[:verbose])
      print_summary(results: results)

      post(results, options)
    end

    def self.post(results, options)
      $stderr.puts "posting into #{options[:target_name]}" if options[:verbose]
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

    def self.extract(files, verbose = false)
      files.each_with_object({}) do |f, sum|
        sum[f] = Parser.new(content(f), post_date(f, verbose)).extract
      end
    end

    def self.content(filename)
      File.open(filename).read
    end

    def self.post_date(filename, verbose = false)
      d = Date.parse(filename) rescue Date.today
      $stderr.puts "extracted date: #{d} from #{filename}" if verbose
      d
    end

    def self.find(dir:, recursive:, verbose:)
      Finder.find(dir: dir, recursive: recursive, verbose: verbose)
    end

    def self.print_found_files(files)
      $stderr.puts "found #{files.size} file(s) to convert:"
      files.each { |f| $stderr.puts f }
    end

    def self.print_explicit_file_list_warning(files)
      string = "Would work on these files, but ignoring explicit file lists for now: #{files}"
      $stderr.puts string
    end
  end
end
