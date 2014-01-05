require 'rspec'
require 'spec_helper'

describe Poster do

  describe Conf do
    it 'should read correct config' do
      conf = Conf.new
      expect(conf[:blogs]).to have(4).elements
      expect(conf[:source_dir]).to eq 'source'
      expect(conf[:posts_dir]).to eq '_posts'
      expect(conf[:default_blog]).to eq :octo
    end
  end

end