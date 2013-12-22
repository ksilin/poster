require 'rspec'
require 'spec_helper'

module Poster
  describe Planter do
    it 'should should copy the post into the appropriate dir' do
      date = Time.now
      Planter.create('the title', 'lawefj afaliw efhalw hfe', date)
      File.delete(Planter.full_path('the title', date))
    end
  end
end