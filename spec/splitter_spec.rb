require 'rspec'
require 'spec_helper'
require 'date'

module Poster
  describe Splitter do

    describe 'Split notes' do

      it 'should read the file' do

        lines= File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        #lines.map { |l|
        #  p "line: #{lines.lineno} : #{l.to_s}" }

      end

      it 'should split note into several posts' do

        file = File.open(File.dirname(__FILE__) + '/assets/example_2013.12.21.md', 'r')
        split = Splitter.split(file.read)
        split.each_with_index {|s, i|
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
        split = Splitter.split(file.read)
        headers = split.map { |post| Splitter.title(post)}
        p "headers: #{headers}"
      end

      it 'should extract dates' do
        date = Date.parse('/assets/example_2013.12.21.md')
        p date
        p "y: #{date.year}, m: #{date.month}, d: #{date.day}"

      end

      it 'should fail on ambiguous dates' do
        expect{Date.parse('/assets/example_4_2013_1_21_2.md')}.to raise_error(ArgumentError)
      end


    end
  end
end