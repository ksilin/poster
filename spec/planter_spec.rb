require 'rspec'
require 'spec_helper'

module Poster
  describe Planter do
    it 'should should copy the post into the appropriate dir' do
      Planter.create('abc', 'the title', 'lawefj afaliw efhalw hfe')
      File.delete(Planter.full_path('abc'))
    end
  end
end