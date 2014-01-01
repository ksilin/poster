require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'
require 'poster/post'

module Poster

  DEFAULT_OPTIONS = {
      :target_name => nil,
      :source_dir => Dir.pwd,
      :recursive => false,
      :overwrite => true,
      :dry_run => false,
      :files => nil
  }

  # TODO control overwriting the target
  # TODO use .erb template
  # TODO complete code block syntax in posts using either a default language or CL param

  def self.convert(options = {})
    options.merge!(DEFAULT_OPTIONS)

    if (options[:files])
      p "Would normally work on these files, but ignoring explicit file lists for now: #{options[:files]}"
    end

    wd = options[:source_dir]
    p "working in : #{wd}"

    files = Finder.find(wd, options[:recursive])
    p "found #{files.size} file(s) to convert:"
    files.each{ |f| p f}

    files.each { |f|
      posts = Parser.extract(f)
      Planter.post(posts)
    }
  end

end
