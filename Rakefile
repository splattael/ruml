require "bundler/gem_tasks"

# Test
require 'rake/testtask'
desc 'Default: run unit tests.'
task :default => :test

AVAILABLE_TEST_FIXTURES = %w[file yaml]

AVAILABLE_TEST_FIXTURES.each do |test_fixture|
  namespace :test do
    Rake::TestTask.new(test_fixture) do |test|
      ENV['TEST_FIXTURE'] = test_fixture
      test.test_files = FileList.new('test/*_test.rb')
      test.libs << 'test'
      test.verbose = true
    end
  end
end

desc "Run tests for #{AVAILABLE_TEST_FIXTURES.join(', ')}"
task :test => AVAILABLE_TEST_FIXTURES.map { |f| "test:#{f}" }

SUPPORTED_RUBIES = %w[ree 1.9.2 1.9.3 jruby rbx]
GEMSPEC = Bundler::GemHelper.new(Dir.pwd).gemspec

def with_ruby(ruby, command)
  rvm     = "#{ruby}@#{GEMSPEC.name}"
  command = %{rvm #{rvm} exec bash -c '#{command}'}

  puts "\n" * 3
  puts "CMD: #{command}"
  puts "=" * 40

  system(command) or raise "command failed: #{command}"
end

namespace :rubies do
  desc "Run tests for following supported platforms #{SUPPORTED_RUBIES.join ", "}"
  task :test do
    command = "bundle check || bundle install && bundle exec rake"
    rubies = ENV['RUBIES'] ? ENV['RUBIES'].split(",") : SUPPORTED_RUBIES
    rubies.each { |ruby| with_ruby(ruby, command) }
  end
end
