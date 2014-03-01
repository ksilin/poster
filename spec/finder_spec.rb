require 'rspec'
require 'spec_helper'
require 'find'

module Poster
  describe Finder do

    let(:markdown_files) { %w(foo_2014_02_15.md bar_2014_02_15.markdown) }
    let(:other_extensions) { %w(foo_2014_02_15.mad bar_2014_02_15.murkdown) }
    let(:not_as_extension) { %w(foo_2014_02_15.md.exe bar_2014_02_15.markdown.pdf) }
    let(:dotfiles) { %w(.2014_02_15.md .2014_02_15.markdown) }
    let(:no_dates) { %w(foo.md bar.markdown) }

    let(:nested) { %w(foo_dir/foo_2014_02_15.md bar_dir/even_deeper/bar_2014_02_15.markdown) }

    describe 'identifying markdown files' do

      it 'should find all .md and .markdown files' do
        with_tempdir(markdown_files) do |dir|
          expect(Finder.find(dir: dir)).to have(2).items
        end
      end

      it 'should find all .md and .markdown files' do
        with_tempdir(other_extensions) do |dir|
          expect(Finder.find(dir: dir)).to be_empty
        end
      end

      it 'should not find files with containing .md and .markdown but not as extensions' do
        with_tempdir(not_as_extension) do |dir|
          expect(Finder.find(dir: dir)).to be_empty
        end
      end

      it 'should not find dotfiles' do
        with_tempdir(dotfiles) do |dir|
          found = Finder.find(dir: dir)
          expect(found).to be_empty
        end
      end
    end

    # TODO: make this optional
    it 'should ignore files without a parseable dates in the name' do
      with_tempdir(no_dates) do |dir|
        expect(Finder.find(dir: dir)).to eq []
      end
    end

    describe 'recursive search' do

      it 'should find files in nested dirs ' do
        with_tempdir(nested) do |dir|
          found = Finder.find(dir: dir, recursive: true)
          expect(found).to have(2).items
        end
      end
    end

    describe 'non-recursive search' do

      it 'should ignore files in nested dirs ' do
        with_tempdir(nested) do |dir|
          expect(Finder.find(dir: dir)).to be_empty
        end
      end
    end

  end
end
