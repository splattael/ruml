require "bundler/gem_tasks"

# Test
require 'rake/testtask'
desc 'Default: run unit tests.'
task :default => :test

Rake::TestTask.new(:test) do |test|
  test.test_files = FileList.new('test/*_test.rb')
  test.libs << 'test'
  test.verbose = true
end
