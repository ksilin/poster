# puts the posts where they belong
# TODO extract inline config (taken from octopress rakefile)
class Planter

  # TODO - this config must go out
  def self.octodir(blogname = '')
    #"#{Dir.home}/Code/Ruby/workspaces/octostuff/#{blogname}"
    "#{Dir.pwd}/#{blogname}"
  end

  # source file directory
  def self.source_dir
    ''#'source'
  end

  # directory for blog files
  def self.posts_dir
    ''#'_posts'
  end

  def self.post(posts)

    posts.each { |post|

      full_path = full_path(post.filename)
      puts "Creating new post: #{full_path}"
      open(full_path, 'w') do |file|
        file.puts post.header
        file.puts post.content
      end
    }
  end

  def self.full_path(filename)
    File.join(octodir, source_dir, posts_dir, filename)
  end
end