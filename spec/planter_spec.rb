require 'rspec'
require 'spec_helper'

module Poster
  describe Planter do
    it 'should should copy the post into the appropriate dir' do
      post = Post.new
      full_path = Planter.full_path(post.filename, :test)
      expect(File.exist?(full_path)).to be false
      Planter.post([post], :test)
      expect(File.exist?(full_path)).to be true
      File.delete(full_path)
      end

    it 'should should not do anything if passed nil' do
      dir_glob = File.join(Dir.pwd, '*')
      before = Dir.glob(dir_glob)
      Planter.post(nil, :test)
      after = Dir.glob(dir_glob)
      expect(after).to match_array before
    end
  end
end