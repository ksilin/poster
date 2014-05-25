require 'rspec'
require 'spec_helper'

module Poster
  describe Validator do

    let(:markdown_files) { %w(foo_2014_02_15.md bar_2014_02_15.markdown) }
    let(:other_extensions) { %w(foo_2014_02_15.mad bar_2014_02_15.murkdown) }
    let(:not_as_extension) { %w(foo_2014_02_15.md.exe bar_2014_02_15.markdown.pdf) }
    let(:dotfiles) { %w(.2014_02_15.md .2014_02_15.markdown) }
    let(:no_dates) { %w(foo.md bar.markdown) }

    describe 'validating markdown file names' do

      it 'only .*.md and .*.markdown files can be valid' do
        markdown_files.each do |f|
          expect(Validator.new.valid_post_filename?(f)).to be true
        end
      end

      it 'other extensions are not valid' do
        other_extensions.each do |f|
          expect(Validator.new.valid_post_filename?(f)).to be false
        end
      end

      it 'filenames containing .md and .markdown, but not as extension are not valid' do
        not_as_extension.each do |f|
          expect(Validator.new.valid_post_filename?(f)).to be false
        end
      end

      # they dont have any dates neither
      it 'dotfiles called .md or .markdown are not valid' do
        dotfiles.each do |f|
          expect(Validator.new.valid_post_filename?(f)).to be false
        end
      end
    end

    # do no process files that do not have a date
    describe 'identifying files with parseable date in the filename' do

      it 'should not find dates where there are none' do
        no_dates.each do |f|
          expect(Validator.new.date_parseable(f)).to be false
        end
      end

      it 'should not find dates where there are none' do
        markdown_files.each do |f|
          expect(Validator.new.date_parseable(f)).to be true
        end
      end

      it 'should fail where Date.parse fails'

    end
  end
end
