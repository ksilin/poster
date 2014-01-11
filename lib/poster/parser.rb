module Poster
  class Parser

    TITLE_NOT_FOUND = 'Parser warning: no title found'

    # TODO - have to dynamically determine the top header level
    # the default top header level is h3 /'###'
    THREE_HASHES = /(?<!#)###(?!#)/
    THREE_HASHES_2 = /(?<!#)###[^#]/

    # m is for 'dot matches newlines' to match multiple lines
    EVERYTHING_BEFORE_AND_INCLUDING_THE_FIRST_3_HASHES =/ .*?(?<!#)###(?!#)/im

    TITLE_LINE_FOLLOWED_BY_A_BLANK_LINE = /(?<!#)###(?!#)[\w ]+\n\s+$/i

    # you can use any single non-digit delimiter char between the digit groups
    # examples use '_'
    # formats: yyyy_mm_dd
    # formats: yyyy_mm_d
    # formats: yyyy_m_dd
    # formats: yyyy_m_d
    # turns out, we dont need that crap, since Date will do it for us
    DATE = /(\d){4}\D(\d){1,2}\D(\d){1,2}/

    def self.split(content)

      return [] if content.nil? || content.empty?


      if !(content =~ THREE_HASHES)

        STDERR.puts "#{TITLE_NOT_FOUND} for : #{content}"
        return []
      end
      puts "found header at #{content =~ THREE_HASHES}"
      # remove everything before the first title delimiter
      content = drop_before_first_title(content)
      content.split(THREE_HASHES).reject { |post| post.nil? || post.empty? }
    end

    def self.drop_before_first_title(content)
      content.slice(content.index(THREE_HASHES)..-1)
    end


    def self.title(post)
      return TITLE_NOT_FOUND if post.nil? || post.empty?
      post.split("\n")[0].strip
    end

    def self.extract(filename)
      content = File.open(filename).read
      posts = split(content)

      posts.reduce([]) { |result, p|
        result << Post.new(title(p), ENV['USERNAME'], p, post_date(filename), Time.now)
      }
    end

    def self.post_date(filename)
      date = Time.now
      begin
        # TODO - this check comes too late, all files must have Date-parseable names
        date = Date.parse(filename)
      rescue => e
        p "unable to parse #{filename} for a date, falling back to #{date}"
      end
      date
    end
  end
end