require 'poster/version'
require 'poster/finder'
require 'poster/splitter'
require 'poster/planter'

module Poster

  # TODO control overwriting the target
  # TODO use .erb template

  def self.convert(files = Finder.find)

    #files =  [*filename] ||
    p "found #{files.size} files to convert"
    files.map{|f|
      p "posting #{f}"
      # TODO - this check comes too late, all files must have Date-parseable names
      date = Date.parse(f) rescue next
      posts = Splitter.split(File.open(f).read)
      posts.each{|post|
        Planter.create(Splitter.title(post), post, date)
      }
    }
  end
end
