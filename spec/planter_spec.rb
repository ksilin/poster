require 'rspec'
require 'spec_helper'

module Poster
  describe Planter do
    it 'should should copy the post into the appropriate dir' do
      post = Post.new
      p File.exist?Planter.full_path(post.filename)
      Planter.post([post])

      p File.exist?Planter.full_path(post.filename)
      File.delete(Planter.full_path(post.filename))
    end
  end
end