require 'poster/version'
require 'poster/finder'
require 'poster/parser'
require 'poster/planter'

module Poster

  # TODO control overwriting the target
  # TODO use .erb template
  # TODO complete code block syntax in posts using either a default language or CL param

  def self.convert(options = {})

    p "Would normally work on these files, but ignoring explicit file lists for now: #{options[:files]}"

    files = Finder.find(options[:recursive])

    p "found #{files.size} files to convert"
    files.map{|f|
      p "preparing #{f} for posting"
      date = Time.now
      begin
        # TODO - this check comes too late, all files must have Date-parseable names
      date = Date.parse(f)
      rescue => e
        p "unable to parse #{f} for a date, falling back to #{date}"
      end

      posts = Parser.split(File.open(f).read)
      posts.each{|post|
        Planter.create(Parser.title(post), post, date)
      }
    }
  end
end
