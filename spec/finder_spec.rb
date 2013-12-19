require 'rspec'
require 'spec_helper'
require 'find'

module Poster
  describe Finder do

    describe 'Finding markdown files' do

      let(:files){['foo.md', 'bar.markdown']}
      let(:not_as_extension){['foo.md.exe', 'bar.markdown.pdf']}
      let(:dotfiles){['.md', '.markdown']}

      it 'should find all .md and .markdown files' do
        with_temp_dir(files) { |dir|
          found = Finder.find(dir)
          expect(found[0]).to match /(\w)+.markdown$/
          expect(found[1]).to match /(\w)+.md$/
        }
      end

      it 'should not find files with containing .md and .markdown but not as extensions' do
        with_temp_dir(not_as_extension) { |dir|
          expect(Finder.find(dir)).to be_empty
        }
      end

      it 'should not find dotfiles called .md .markdown' do
        with_temp_dir(dotfiles) { |dir|
          expect(Finder.find(dir)).to be_empty
        }
      end
    end
  end
end

