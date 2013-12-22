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

      posts = Splitter.split(File.open(f).read)
      p posts
    }
  end
end
