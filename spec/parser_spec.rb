require 'rspec'
require 'spec_helper'
require 'date'

module Poster
  describe Parser do

    describe 'Split notes' do

      it 'should split note into several posts' do

        file = File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        split = Parser.split(file.read)
        expect(split).to have(2).items
        split.each_with_index { |s, i|
          p "#{i}: #{s}"
        }
      end

      it 'should return an empty Array when the source file is empty' do

        with_tempdir([:foo]){|dir|
          filename = Dir.glob(File.join(dir, '*'))[0]
          file = File.open(filename, 'r')
          split = Parser.split(file.read)
          expect(split).to match_array []
        }
      end

      it 'should return an empty Array when file empty' do

        with_tempdir_and_files([:foo]){|dir, files|
          split = Parser.split(File.open(files[0]).read)
          expect(split).to match_array []
        }
      end

      it 'should return an empty Array when title delimiter not found' do

        with_tempdir_and_files([:foo]){|dir, files|
          split = Parser.split(File.open(files[0]).read)
          expect(split).to match_array []
        }
      end
    end

    describe 'title extraction' do

      it 'should extract titles' do

        file = File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        split = Parser.split(file.read)
        titles = split.map { |post| Parser.title(post) }
        expect(titles).to match_array ['The first post', 'The second post']
      end

      it 'should provide default title if title extraction fails'do
        expect(Parser.title('')).to be_equal Parser::TITLE_NOT_FOUND
      end

      it 'should support configurable title format'

    end

    describe 'date parsing' do

      it 'should extract dates' do
        date = Date.parse('/assets/example_2013.12.21.md')
        p date
        p "y: #{date.year}, m: #{date.month}, d: #{date.day}"
      end

      it 'should fail on ambiguous dates' do
        expect { Date.parse('/assets/example_4_2013_1_21_2.md') }.to raise_error(ArgumentError)
      end
    end

    # the tags are written on the last non-space line of the post. Format: [tag1, tag2], whitespace optional
    # TODO perhaps arbitrary non-word delimiters?
    describe 'tag extraction' do

      it 'should not extract tags from untagged posts' do

      end
      it 'should all and only tags, independent of their content (or should I restrict to alphanumeric?)'
      it 'should extract tags surrounded by whitespace and blank lines'

    end
  end
end