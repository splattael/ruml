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
    command = "bundle check || bundle install && rake"
    rubies = ENV['RUBIES'] ? ENV['RUBIES'].split(",") : SUPPORTED_RUBIES
    rubies.each { |ruby| with_ruby(ruby, command) }
  end
end
