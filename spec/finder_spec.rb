require 'rspec'
require 'spec_helper'
require 'find'

module Poster
  describe Finder do

    let(:files) { %w(foo_2014_02_15.md bar_2014_02_15.markdown) }
    let(:not_as_extension) { %w(foo.md.exe bar.markdown.pdf) }
    let(:dotfiles) { %w(.md .markdown) }

    let(:nested) { %w(foo_dir/foo_2014_02_15.md bar_dir/even_deeper/bar_2014_02_15.markdown) }

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

    # do no process files that do not have a date
    # TODO - make this optional
    describe 'identifying files with parseable date in the filename' do

      it 'should ignore files without a parseable dates in the name' do
        with_tempdir(['nodate.md']) { |dir|
          expect(Finder.find(dir)).to eq []
        }
      end

      it 'should find files with a parseable dates in the name' do
        with_tempdir(['notes_2014.01.29.md']) { |dir|
          expect(Finder.find(dir)).to have(1).item
        }
      end

      it 'should not find dates where there are none' do
          expect(Finder.date_parseable('nodate.md')).to be false
      end

      it 'should fail where Date.parse fails'

      it 'should accept files with parseable dates in the name' do
        expect(Finder.date_parseable('notes_2014.01.29.md')).to be_true
      end


    end


    describe 'recursive search' do

      it 'should find files in nested dirs ' do
        with_tempdir(nested) { |dir|
          found = Finder.find(dir, true)
          puts "found: #{found.join('\n')}"
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

