require 'rspec'
require 'spec_helper'
# require 'active_support/core_ext/numeric/time'

module Poster
  describe Post do

    it 'should create a valid post with default params' do
      post = Post.new
      expect(post.title).to eq 'Title could not be found'
      expect(post.author).to eq ENV['USERNAME']
      expect(post.content).not_to be_empty
      expect(post.created_at).to be_between(Time.now - 60, Time.now)
      expect(post.posted_at).to be_between(Time.now - 60, Time.now)
    end

    it 'should create a valid filename with default params' do
      post = Post.new
      filename = post.filename
      expect(filename).to match(/^(\d)+-+.*.markdown$/)
    end
  end
end
