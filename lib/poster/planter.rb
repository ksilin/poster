# puts the posts where they belong
# TODO extract inline config (taken from octopress rakefile)
class Planter

  def self.post(posts, blog)

    Array(posts).each { |post|
      full_path = full_path(post.filename, blog)
      # TODO - if the full path is not available, the processing
      puts "Creating new post: #{full_path}"
      open(full_path, 'w') do |file|
        file.puts post.header
        file.puts post.content
      end
    }
  end

  def self.full_path(filename, blog)
    # TODO extract conf from here
    conf = Conf.new
    return filename unless  conf[:blogs][blog]

    File.join(conf[:blogs][blog], conf[:source_dir], conf[:posts_dir], filename)
  end
end