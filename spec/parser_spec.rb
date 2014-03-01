require 'rspec'
require 'spec_helper'
require 'date'

module Poster
  describe Parser do

    let(:no_posts) { "bla \n text\n" }
    let(:one_post) { "### bla \n text\n" }
    let(:two_posts) { "### bla \n text\n ### blub \n more text\n" }

    let(:one_post_after_plain_text) { 'hello ### goodbye' }

    let(:wrong_delimiter) { "***bla \n text\n" }
    let(:too_short_delimiter) { "## bla \n text\n" }
    let(:too_long_delimiter) { "#### bla \n text\n" }

    describe 'splitting notes' do

      it 'should split notes into posts' do

        split = Parser.split(one_post)
        expect(split).to have(1).item
      end

      it 'should split multiple posts' do

        split = Parser.split(two_posts)
        expect(split).to have(2).items
      end

      it 'should not find posts in an empty string' do
        split = Parser.split('')
        expect(split).to match_array []
      end

      it 'should not find posts when the source string does not contain delimiter' do
        split = Parser.split(no_posts)
        expect(split).to match_array []
      end

      it 'should not find posts when the string contains a different delimiter' do
        split = Parser.split(wrong_delimiter)
        expect(split).to match_array []
      end

      it 'should not find posts when the string contains a too short delimiter' do
        split = Parser.split(too_short_delimiter)
        expect(split).to match_array []
      end

      it 'should not find posts when the string contains a too long delimiter' do
        split = Parser.split(too_long_delimiter)
        expect(split).to match_array []
      end

      # this is kinda obvious. Am I testing File.read here?
      it 'should not find posts in an empty file' do
        with_tempdir_and_files([:foo]) do |_dir, files|
          split = Parser.split(File.open(files[0]).read)
          expect(split).to match_array []
        end
      end

    end

    describe 'title extraction' do

      it 'should extract titles' do

        split = Parser.split(one_post)
        titles = split.map { |post| Parser.first_line(post) }
        expect(titles).to match_array ['bla']
      end

      it 'should extract multiple titles' do
        split = Parser.split(two_posts)
        titles = split.map { |post| Parser.first_line(post) }
        expect(titles).to match_array %w(bla blub)
      end

      it 'should drop everything before the first title' do

        split = Parser.split(one_post_after_plain_text)
        titles = split.map { |post| Parser.first_line(post) }
        expect(titles).to match_array ['goodbye']
      end

      # not sure what to do with files that do not have s single title in them
      # probably the best thing would be to try different title delimiters and
      # suggest the most probably candidates
      # what char is found 3 or 4 times most in a row that is followed by a blank line

      it 'only three hashes count as a title' do
        split = Parser.split(" # a \n ## b \n #### c")
        expect(split).to match_array []
      end

      it 'should drop everything before the first title' do
        split = Parser.drop_everything_before_first_title(one_post_after_plain_text)
        expect(split).to match '### goodbye'
      end

      it 'a title is just the first line of a string' do
        title = Parser.first_line(no_posts)
        expect(title).to eq 'bla'
      end

      it 'should fail if title extraction fails 2' do
        title = Parser.first_line('')
        expect(title).to eq ''
      end

      it 'should support configurable title format'

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
