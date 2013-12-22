# puts the posts where they belong
# TODO extract inline config (taken from octopress rakefile)
class Planter

  # TODO - this config must go
  def self.octodir(blogname = 'octo')
    "#{Dir.home}/Code/Ruby/workspaces/octostuff/#{blogname}"
  end
  # source file directory
  def self.source_dir
    'source'
  end

  # directory for blog files
  def self.posts_dir
    '_posts'
  end

  def self.create(title, content, date)

    full_path = full_path(title, date)
    puts "Creating new post: #{full_path}"
    open(full_path, 'w') do |post|
      post.puts '---'
      post.puts 'layout: post'
      post.puts "title: \"#{title.gsub(/&/, '&amp;')}\""
      post.puts "date: #{post_date}"
      post.puts 'comments: true'
      post.puts 'categories: '
      post.puts '---'
      post.puts
      post.puts content
    end
  end

  # staying real fopr the beginning
  def self.post_date
    Time.now.strftime('%Y-%m-%d %H:%M:%S %z')
  end

  def self.full_path(filename, date)
    File.join(octodir, source_dir, posts_dir, full_filename(filename, date))
  end

  def self.full_filename(filename, date)
    "#{date.year}-#{date.month}-#{date.day}-#{filename}.markdown"
  end

end