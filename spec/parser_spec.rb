require 'rspec'
require 'spec_helper'
require 'date'

module Poster
  describe Parser do

    describe 'strange case of matching operators' do
      it 'should match title delimiters' do
        p 'abc' =~ /b/ # => 1
        p 'abc' !=~/b/ # => true
        p !('abc' =~ /b/) # => false
      end
    end

    describe 'Split notes' do

      # TODO - excercise split with simple strings
      it 'should split note into several posts' do

        file = File.open(Dir.pwd + '/spec/assets/example_2013.12.21.md', 'r')
        split = Parser.split(file.read)
        split.each_with_index { |s, i|
          p "#{i}: #{s}"
        }
        expect(split).to have(2).items
      end

      it 'should return an empty Array when the source string is empty' do
        split = Parser.split('')
        expect(split).to match_array []
      end

      it 'should return an empty Array when file empty' do

        with_tempdir_and_files([:foo]) { |dir, files|
          split = Parser.split(File.open(files[0]).read)
          expect(split).to match_array []
        }
      end

      it 'should return an empty Array when title delimiter not found' do

        with_tempdir_and_files([:foo]) { |dir, files|
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

      it 'should extract titles' do

        split = Parser.split('### hello')
        titles = split.map { |post| Parser.title(post) }
        expect(titles).to match_array ['hello']
      end

      it 'should drop everything before the first title' do

        split = Parser.split(" hello \n and ### goodbye")
        titles = split.map { |post| Parser.title(post) }
        expect(titles).to match_array ['goodbye']
      end

      # not sure what to do with fiels that do not have s single title in them
      # probably the best thing would be to try different title delimiters and
      # suggest the most probably candidates
      #  what char is found 3 or 4 times most in a row that is followed by a blank line

      it 'only three hashes are a title' do

        split = Parser.split(" # a \n ## b \n #### c")
        expect(split).to match_array []
      end


      it 'should drop everything before the first title' do

        split = Parser.drop_before_first_title(" hello \n and ### goodbye")
        expect(split).to match '### goodbye'
      end

      it 'should provide default title if title extraction fails' do
        expect(Parser.title('')).to eq Parser::TITLE_NOT_FOUND
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

    describe 'Post extraction' do
      it 'should create two Post instances' do
        filename = Dir.pwd + '/spec/assets/example_2013.12.21.md'
        posts = Parser.extract(filename)
        pp posts
      end
    end

  end
end