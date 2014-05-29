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

        split = Parser.new(one_post).split
        expect(split).to have(1).item
      end

      it 'should split multiple posts' do

        split = Parser.new(two_posts).split
        expect(split).to have(2).items
      end

      it 'should not find posts in an empty string' do
        split = Parser.new('').split
        expect(split).to match_array []
      end

      it 'should not find posts when the source string does not contain delimiter' do
        split = Parser.new(no_posts).split
        expect(split).to match_array []
      end

      it 'should not find posts when the string contains a different delimiter' do
        split = Parser.new(wrong_delimiter).split
        expect(split).to match_array []
      end

      it 'should not find posts when the string contains a too short delimiter' do
        split = Parser.new(too_short_delimiter).split
        expect(split).to match_array []
      end

      it 'should not find posts when the string contains a too long delimiter' do
        split = Parser.new(too_long_delimiter).split
        expect(split).to match_array []
      end

      # this is kinda obvious. Am I testing File.read here?
      it 'should not find posts in an empty file' do
        with_tempdir_and_files([:foo]) do |_dir, files|
          split = Parser.new(File.open(files[0]).read).split
          expect(split).to match_array []
        end
      end

    end

    describe 'title extraction' do

      it 'should extract titles'

        # split = Parser.new(one_post).split
        # titles = split.map { |post| Parser.first_line(post) }
        # expect(titles).to match_array ['bla']
      # end

      it 'should extract multiple titles'
      #   split = Parser.new(two_posts).split
      #   titles = split.map { |post| Parser.first_line(post) }
      #   expect(titles).to match_array %w(bla blub)
      # end

      it 'should drop everything before the first title'
      #
      #   split = Parser.new(one_post_after_plain_text)
      #   titles = split.map { |post| Parser.first_line(post) }
      #   expect(titles).to match_array ['goodbye']
      # end

      # not sure what to do with files that do not have s single title in them
      # probably the best thing would be to try different title delimiters and
      # suggest the most probably candidates
      # what char is found 3 or 4 times most in a row that is followed by a blank line

      it 'only three hashes count as a title' do
        split = Parser.new(" # a \n ## b \n #### c").split
        expect(split).to match_array []
      end

      it 'should drop everything before the first title' do
        split = Parser.new(one_post_after_plain_text).drop_everything_before_first_title
        expect(split).to match '### goodbye'
      end

      it 'a title is just the first line of a string'
        # title = Parser.new(no_posts).first_line
        # expect(title).to eq 'bla'
      # end

      it 'should fail if title extraction fails 2'
      #   title = Parser.first_line('')
      #   expect(title).to eq ''
      # end

      it 'should support configurable title format'

    end

    # the tags are written on the last non-space line of the post. Format: [tag1, tag2], whitespace optional
    # TODO perhaps arbitrary non-word delimiters?
    describe 'tag extraction' do

      it 'should not extract tags from untagged posts'
      it 'should all and only tags, independent of their content (or should I restrict to alphanumeric?)'
      it 'should extract tags surrounded by whitespace and blank lines'

    end

    describe 'Post extraction' do
      it 'should create two Post instances'
    #     filename = Dir.pwd + '/spec/assets/example_2013.12.21.md'
    #     posts = Parser.extract(filename)
    #     pp posts
    #   end
    end

  end
end
