require 'rspec'
require 'spec_helper'
require 'pry'

module Poster
  describe Planter do

    it 'should copy the post into the appropriate dir' do
      post = Post.new
      full_path = File.join(Planter.post_dir(:test), post.filename)

      File.delete full_path if File.exist? full_path

      puts "looking for #{full_path}"
      Planter.post(posts: [post], target: :test)

      expect(File.exist?(full_path)).to be true
      File.delete(full_path)
    end

    it 'should should not do anything if passed nil' do
      files_in_current_dir = File.join(Dir.pwd, '*')
      before = Dir.glob(files_in_current_dir)

      Planter.post(posts: nil, target: :test)

      after = Dir.glob(files_in_current_dir)
      expect(after).to match_array before
    end

    it 'should not post anything if target directory does not exist'
    it 'should message to stderr if target directory does not exist'

    it 'should overwrite existing files by default' do

    end

    describe 'overwriting files'
    it 'should message to stderr when overwriting files'
    it 'should not overwrite files if newer than the posted_at date'
    it 'should message to stderr when not overwriting files'

    it 'should not overwrite files when overwriting is forbidden'

  end
end
