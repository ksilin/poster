require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'
require 'poster/post'
require 'poster/conf'

module Poster

  DEFAULT_OPTIONS = {
      :blog => :test,
      :source_dir => Dir.pwd,
      :recursive => false,
      :overwrite => true,
      :dry_run => false,
      :files => nil
  }

  # TODO control overwriting the target
  # TODO use .erb template
  # TODO complete code block syntax in posts using either a default language or CL param

  def self.convert(opts = {})
    options = DEFAULT_OPTIONS.merge(opts)

    if (options[:files])
      $stderr.puts "Would normally work on these files, but ignoring explicit file lists for now: #{options[:files]}"
    end

    wd = options[:source_dir]
    $stderr.puts "working in : #{wd}"

    files = Finder.find(wd, options[:recursive])
    $stderr.puts "found #{files.size} file(s) to convert:"
    files.each{ |f| p f}

    files.each { |f|
      posts = Parser.extract(f)
      $stderr.puts "extracted #{posts.size} posts from #{f}"
      Planter.post(posts, options[:blog])
    }
  end

end
