require 'rspec'
require 'spec_helper'
require 'date'

module Poster
  describe Parser do

    describe 'Split notes' do

      it 'should read the file' do

        lines= File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        #lines.map { |l|
        #  p "line: #{lines.lineno} : #{l.to_s}" }

      end

      it 'should split note into several posts' do

        file = File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        split = Parser.split(file.read)
        split.each_with_index { |s, i|
          p "#{i}: #{s}"
        }
      end

      it 'should split' do

        file = File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        content = file.read
        p "content: #{content}"
      end

      it 'should extract headers' do

        file = File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        split = Parser.split(file.read)
        headers = split.map { |post| Parser.title(post) }
        p "headers: #{headers}"
      end
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
    describe 'extract tags' do

      it 'should not extract tags from untagged posts'
      it 'should all and only tags, independent of their content (or should I restrict to alphanumeric?)'
      it 'should extract tags surrounded by whitespace and blank lines'

    end
  end
end