[![Code Climate](https://codeclimate.com/github/ksilin/poster.png)](https://codeclimate.com/github/ksilin/poster)
[![Build Status](https://travis-ci.org/ksilin/poster.png)](https://travis-ci.org/ksilin/poster)
[![GitHub version](https://badge.fury.io/gh/ksilin%2Fposter.png)](http://badge.fury.io/gh/ksilin%2Fposter)
[![Coverage Status](https://coveralls.io/repos/ksilin/poster/badge.png?branch=master)](https://coveralls.io/r/ksilin/poster?branch=master)


# Poster

While learning how to make gems, I am writing this simple util to transform my usual markup  

## Installation

Add this line to your application's Gemfile:

    gem 'poster'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install poster

## Usage

    $ poster

Executed in a folder with notes named like something_2014.01.27.md
it will convert the file into 0 or more files following the [Jekyll post format](http://jekyllbootstrap.com/lessons/jekyll-introduction.html): `@YEAR-MONTH-DATE-title.MARKUP@`.

There may be multiple posts inside a file. Each post must start with `###` (the only supported delimiter ATM, but it's on my lsit :) and contain a title text on the same line.

If the file does not contain a single `###`, no posts wil be extracted.

the files must
* have either `.md` or `.markdown` extensions
* contain a date in the file name that is parseable by [`Date.parse`](http://ruby-doc.org/stdlib-2.1.0/libdoc/date/rdoc/Date.html#method-c-parse)

TODO: make date position configurable - on the top of the file or inside the post title
TODO: make title markup configurable
TODO: add interactive mode for editing dates, tags and titles
TOOD: make extensions configurable


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
