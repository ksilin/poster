Feature: We can convert existing fiels to posts
  As a busy developer with a lot of things to do
  I want to convert files containing note to the octopress format and put them into a blog
  Scenario: Converting a notes file
    Given the file "tmp/notes_2013.12.31.md" doesn't exist
    When I successfully run `poster`
    And the stdout should contain "Some new task"