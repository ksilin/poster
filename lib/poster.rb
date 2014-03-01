require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'
require 'poster/post'
require 'poster/conf'

module Poster
  DEFAULT_OPTIONS = {
      blog: :test,
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
    posts = extract(files, options[:verbose])
    Planter.post(posts, options[:blog])
  end

  def self.extract(files, verbose)
    files.inject([]) do |sum, f|
      extracted = Parser.extract(f)
      sum += extracted
      $stderr.puts "extracted #{extracted.size} posts from #{f}" if verbose
      sum
    end
  end

  def self.find(options)
    files = Finder.find(options[:source_dir], options)
    verbose = options[:verbose]
    $stderr.puts "found #{files.size} file(s) to convert:" if verbose
    files.each { |f| $stderr.puts f }
    files
  end

  def self.print_explicit_file_list_warning(files)
    string = "Would work on these files, but ignoring explicit file lists for now: #{files}"
    $stderr.puts string
  end
end
