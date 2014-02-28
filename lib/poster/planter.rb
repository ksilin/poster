# puts the posts where they belong
class Planter

  # TODO - force, forbid or query overwriting of existing files
  # overwrite controls
  def self.post(posts, blog, opts = {})
    options = {overwrite: true, force: false, dry_run: false, verbose: false}.merge(opts)

    Array(posts).each { |post|

      post_dir = post_dir(blog)
      fail "target directory #{post_dir} not found" unless Dir.exist? post_dir

      full_path = File.join(post_dir, post.filename)

      exists = File.exist? full_path
      if exists
        warn "file ##{full_path} already exists: #{exists}"
        $stderr.puts "stats for file ##{full_path}" if options[:verbose]
        $stdout.puts "#{File.stat(full_path).inspect}" if options[:verbose]
      end

      # TODO - if the path dir does not exist, the processing should skip this file
      $stdout.puts "Creating new post: #{full_path}"
      write_post_to_file(full_path, post) unless options[:dry_run]
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
