module Poster
  class Post

    # TODO add tags/categories

    attr_reader :title, :author, :content, :created_at, :posted_at

    # TODO - to named key params
    def initialize(title = 'Title could not be found', author = ENV['USERNAME'], content = 'lorem ipsum', created_at = Time.now, posted_at = Time.now )
      @title = title
      @author = author
      @content = content

      @created_at = created_at
      @posted_at = posted_at
    end

    def header
      h = []
      h << '---'
      h << 'layout: post'
      h << "title: \"#{title.gsub(/&/, '&amp;')}\""
      h << "date: #{posted_at}"
      h << "author: #{author}"
      # TODO - make 'published' configurable over CL
      h << 'published: true'
      h << 'comments: true'
      h << 'categories: '
      h << '---'
      h << ''
      h.join("\n")
    end

    def filename
      "#{created_at.year}-#{created_at.month}-#{created_at.day}-#{slug}.markdown"
    end

    private

    # replace spaces with '-'
    # remove non-word characters
    def slug
      title.split.join('-').gsub(/[^\w-]+/, '')
    end

  end
end