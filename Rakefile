require "bundler/gem_tasks"

# Test
require 'rake/testtask'
desc 'Default: run unit tests.'
task :default => :test

namespace :test do
  desc "Test runner"
  Rake::TestTask.new :run do |test|
    ENV['TEST_FIXTURE'] ||= "file"
    test.test_files = FileList.new('test/**/*_test.rb')
    test.libs << 'test'
    test.verbose = true
  end
end

AVAILABLE_TEST_FIXTURES = %w[file yaml]

AVAILABLE_TEST_FIXTURES.each do |test_fixture|
  namespace :test do
    desc "Run tests with fixture #{test_fixture}"
    task test_fixture do
      system "bundle exec rake test:run TEST_FIXTURE=#{test_fixture}"
    end
  end
end

desc "Run tests for #{AVAILABLE_TEST_FIXTURES.join(', ')}"
task :test => AVAILABLE_TEST_FIXTURES.map { |f| "test:#{f}" }
