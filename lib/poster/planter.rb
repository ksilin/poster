# puts the posts where they belong
module Poster
  module Planter
    # TODO: force, forbid or query overwriting of existing files
    def self.post(posts:, target:, opts: {})
      options = { overwrite: true, force: false, dry_run: false, verbose: false }.merge(opts)
      Array(posts).each do |post|

        post_dir = post_dir(target)
        fail "target directory #{post_dir} not found" unless Dir.exist? post_dir

        full_path = File.join(post_dir, post.filename)
        warn_if_file_exists(full_path) if options[:verbose]
        write_post_to_file(full_path, post) unless options[:dry_run]
      end
    end

    def self.warn_if_file_exists(full_path)
      exists = File.exist? full_path
      warn "file ##{full_path} already exists, overwriting" if exists
    end

    def self.write_post_to_file(full_path, post)
      open(full_path, 'w') do |file|
        file.puts post.header
        file.puts post.content
      end
    end

    def self.post_dir(target_name)
      conf = Conf.new
      target_path = conf[:blogs][target_name.to_sym]
      return Dir.pwd unless target_path
      File.join(Dir.home, target_path, conf[:source_dir], conf[:posts_dir])
    end
  end
end
