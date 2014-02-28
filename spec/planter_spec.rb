require 'rspec'
require 'spec_helper'

module Poster
  describe Planter do

    it 'should copy the post into the appropriate dir' do
      post = Post.new
      full_path = File.join(Planter.post_dir(:test), post.filename)
      expect(File.exist?(full_path)).to be false

      Planter.post([post], :test)

      expect(File.exist?(full_path)).to be true
      File.delete(full_path)
      end

    it 'should should not do anything if passed nil' do
      files_in_current_dir = File.join(Dir.pwd, '*')
      before = Dir.glob(files_in_current_dir)

      Planter.post(nil, :test)

      after = Dir.glob(files_in_current_dir)
      expect(after).to match_array before
    end

    it 'should not post anything if target directory does not exist'
    it 'should message to stderr if target directory does not exist'

    it 'should overwrite existing files by default' do

    end
    it 'should message to stderr when overwriting files'
    it 'should not overwrite existing files when if they are newer than the posted_at date'
    it 'should message to stderr when not overwriting existing files when if they are newer than the posted_at date'

    it 'should not overwrite existing files when overwriting is forbidden'

  end
end