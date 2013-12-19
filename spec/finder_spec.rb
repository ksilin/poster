require 'rspec'
require 'spec_helper'
require 'find'

module Poster
  describe Finder do

    describe 'Finding markdown files' do

      let(:files){['foo.md', 'bar.markdown']}

      it 'should find all .md and .markdown files' do
        with_temp_dir(files) { |dir|
          found = Finder.find(dir)
          expect(found[0]).to match /(\w)+.markdown$/
          expect(found[1]).to match /(\w)+.md$/
        }
      end
    end
  end
end

