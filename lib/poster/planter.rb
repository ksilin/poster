# puts the posts where they belong
class Planter

  # TODO - force, forbid or query overwriting
  def self.post(posts, blog)

    Array(posts).each { |post|

      post_dir = post_dir(blog)
      raise "target directory #{post_dir} not found" unless Dir.exist? post_dir

      full_path = File.join(post_dir, post.filename)
      # TODO - if the path dir does not exist, the processing should skip this file
      puts "Creating new post: #{full_path}"
      write_post_to_file(full_path, post)
    }
  end

  def self.write_post_to_file(full_path, post)
    open(full_path, 'w') do |file|
      file.puts post.header
      file.puts post.content
    end
  end

  def self.post_dir(blog)
    # TODO extract conf instantiation from here
    conf = Conf.new
    return Dir.pwd unless conf[:blogs][blog]
    File.join(Dir.home, conf[:blogs][blog], conf[:source_dir], conf[:posts_dir])
  end
end