require 'rspec'
require 'spec_helper'

module Poster
  describe Planter do
    it 'should should copy the post into the appropriate dir' do
      post = Post.new
      Planter.post([post])
      File.delete(Planter.full_path(post.filename))
    end
  end
end