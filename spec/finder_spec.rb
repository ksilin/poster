require 'rspec'
require 'spec_helper'
require 'find'

module Poster
  describe Finder do

    let(:files) { %w(foo.md bar.markdown)}
    let(:not_as_extension) { %w(foo.md.exe bar.markdown.pdf) }
    let(:dotfiles) { %w(.md .markdown) }

    let(:nested) { %w(foo_dir/foo.md bar_dir/even_deeper/bar.markdown) }

    let(:with_garbage) { list = to_filelist('foo.md')
    list['foo.md'] = '123423644tzerztbertzber'
    list
    }

    describe 'identifying markdown files' do

      it 'should find all .md and .markdown files' do
        with_tempdir(files) { |dir|
          found = Finder.find(dir)
          expect(found[0]).to match /(\w)+.markdown$/
          expect(found[1]).to match /(\w)+.md$/
        }
      end

      it 'should not find files with containing .md and .markdown but not as extensions' do
        with_tempdir(not_as_extension) { |dir|
          expect(Finder.find(dir)).to be_empty
        }
      end

      it 'should not find dotfiles called .md or .markdown' do
        with_tempdir(dotfiles) { |dir|
          expect(Finder.find(dir)).to be_empty
        }
      end
    end

    describe 'recursive search' do

      it 'should find files in nested dirs ' do
        with_tempdir(nested) { |dir|
          found = Finder.find(dir, true)
          expect(found).to have(2).items
        }
      end
    end

    describe 'non-recursive search' do

      it 'should ignore files in nested dirs ' do
        with_tempdir(nested) { |dir|
          expect(Finder.find(dir)).to be_empty
        }
      end
    end

  end

end

