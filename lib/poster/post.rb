module Poster
  class Post
    # TODO: add tags/categories

    attr_reader :title, :author, :content, :publish, :created_at, :posted_at

    # TODO: to named key params
    def initialize(title = 'Title could not be found', author = ENV['USERNAME'], content = 'lorem ipsum', publish = true, created_at = Time.now, posted_at = Time.now)
      @title = title
      @author = author
      @content = content
      @publish = publish
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
      h << "published: #{publish}"
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
