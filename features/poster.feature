Feature: We can convert existing files to posts
  As a busy developer with a lot of things to do
  I want to convert files containing notes to the octopress format and put them into a blog

#   `pwd`, run in a step here returns <path_to_project>/tmp/aruba

  Scenario: Running in a directory without markdown files has no effect
    Given the file "notes_2013.12.31.md" doesn't exist
    And I successfully run `ruby ../../bin/poster`
    Then the stdout should contain "found 0 file(s) to convert"
    And the stdout should not contain "notes_2013.12.31.md"

  Scenario: Converting a notes file
    Given an empty file named "notes_2013.12.31.md"
    And I successfully run `ruby ../../bin/poster`
    Then the stdout should contain "found 1 file(s) to convert"
    And the stdout should contain "notes_2013.12.31.md"
    And the output should match /extracted 0 posts from .*notes_2013.12.31.md/
