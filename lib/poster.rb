require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'

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

    p "found #{files.size} files to convert:"
    files.each{ |f| p f}

    files.map { |f|

      posts = Parser.split(File.open(f).read)
      posts.each { |post|
        title = Parser.title(post)
        p "creating post titled #{title}"
        Planter.create(title, post, post_date(f))
      }
    }
  end

  def self.post_date(f)
    date = Time.now
    begin
      # TODO - this check comes too late, all files must have Date-parseable names
      date = Date.parse(f)
    rescue => e
      p "unable to parse #{f} for a date, falling back to #{date}"
    end
    date
  end
end
