require 'poster'
require 'tmpdir'

# for test coverage reports
require 'coveralls'
Coveralls.wear!

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

def with_tempdir(filenames = {})
  Dir.mktmpdir do |dir|
    make_tempfiles(dir, filenames)
    yield dir
  end
end

def with_tempdir_and_files(filenames = {})
  Dir.mktmpdir do |dir|
    files = make_tempfiles(dir, filenames)
    yield(dir, files)
  end
end

def make_tempfiles(dir, filenames)
  filenames.reduce([]) do |fn, name, content|

    file_name = File.join(dir, name.to_s)
    # not simply usign the dir, since filenames may contain paths
    FileUtils.mkdir_p(File.dirname(file_name))

    p "writing #{content} to #{file_name}"
    open(file_name, 'w') { |f| f.write content }
    fn << file_name
  end
end

# creating temp directories recursively
# directories argument is used for recursion and is not supposed to be used by the client/user
def with_tempdirs(filenames = {}, directories = [], &block)
  if filenames.empty?
    return block.call(directories)
  end

  with_tempdir(filenames.pop) do |dir|
    with_tempdirs(filenames, directories << dir, &block)
  end
end

# TODO: test this
# creating temp directories recursively
# directories argument is used for recursion and is not supposed to be used by the client/user
def with_tempdirs_and_files(filenames = {}, directories = [], files = [] & block)
  block.call(directories, files) if filenames.empty?

  with_tempdir_and_files(filenames.pop) do |dir, f|
    with_tempdirs_and_files(filenames, directories << dir, files.concat(f), &block)
  end
end

def to_filelist(*names)
  names.reduce({}) do |h, name|
    h[name] = nil
    h
  end
end
