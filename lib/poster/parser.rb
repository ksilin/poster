module Poster
  class Parser

    TITLE_NOT_FOUND = 'Poster warning: no title found'

    # TODO - have to dynamically determine the top header level
    # the default top header level is h3 /'###'
    THREE_HASHES = /(?<!#)###(?!#)/
    THREE_HASHES_2 = /(?<!#)###[^#]/

    # you can use any single non-digit delimiter char between the digit groups
    # examples use '_'
    # formats: yyyy_mm_dd
    # formats: yyyy_mm_d
    # formats: yyyy_m_dd
    # formats: yyyy_m_d
    # turns out, we dont need that crap, since Date will do it for us
    DATE = /(\d){4}\D(\d){1,2}\D(\d){1,2}/

    def self.split(content)
      content.split(THREE_HASHES).reject{|post| post.nil? || post.empty?}
    end


    def self.title(post)
      return TITLE_NOT_FOUND if post.nil? || post.empty?
      post.split("\n")[0].strip
    end
  end
end