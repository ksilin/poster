module Poster
  class Parser
    # TODO: have to dynamically determine the top header level
    # the default top header level is h3 /'###'
    THREE_HASHES = /(?<!#)###(?!#)/
    THREE_HASHES_2 = /(?<!#)###[^#]/

    # m is for 'dot matches newlines' to match multiple lines
    EVERYTHING_BEFORE_AND_INCLUDING_THE_FIRST_3_HASHES = / .*?(?<!#)###(?!#)/im

    # the multiplatform match for newline is rather '\r\n?|\n' than a simple '\n'
    # but on unixes and mac \n should work fine
    # TODO: test this
    TITLE_LINE_FOLLOWED_BY_A_BLANK_LINE = /(?<!#)###(?!#)[\w ]+\n\s+$/i

    # you can use any single non-digit delimiter char between the digit groups
    # examples use '_'
    # formats: yyyy_mm_dd
    # formats: yyyy_mm_d
    # formats: yyyy_m_dd
    # formats: yyyy_m_d
    # turns out, we dont need that crap, since Date will do it for us
    DATE = /(\d){4}\D(\d){1,2}\D(\d){1,2}/

    attr_reader :content, :date

    def initialize(content, date = Date.today, verbose = false)
      @content = content
      @date = date
      @verbose = verbose
    end

    # TODO: extracting Post instances is not the job of a parser. move it up.
    def extract
      as_posts(split)
    end

    def split
      return [] if empty?(content) || contains_no_titles(content)

      c = drop_everything_before_first_title
      c.split(THREE_HASHES).reject { |post| empty?(post) }
    end

    def contains_no_titles(content)
      content !~ THREE_HASHES
    end

    def empty?(content)
      content.nil? || content.empty?
    end

    def drop_everything_before_first_title
      content.slice(content.index(THREE_HASHES)..-1)
    end

    def first_line(post)
      return '' if (post.nil? || post.empty?)
      post.split("\n")[0].strip
    end

    def as_posts(posts)
      posts.reduce([]) do |result, p|
        result << Post.new(first_line(p), ENV['USERNAME'], p, date, Time.now)
      end
    end
  end
end
