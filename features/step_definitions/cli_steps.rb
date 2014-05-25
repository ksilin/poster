
# for absolute file paths
Given /^the file "(\/.+)" doesn't exist$/ do |file|
  puts 'absolute path'
  FileUtils.rm(file) if File.exist? file
end

# relative path (^[^\/].+)
Given /^the file "([^\/].+)" doesn't exist$/ do |file|
  puts 'relative path'
  FileUtils.rm(file) if File.exist? file
end
