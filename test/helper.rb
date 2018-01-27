require 'rubygems'
require 'bundler/setup'

require 'minitest/spec'
require 'minitest/autorun'

require 'ruml'

Mail.defaults do
  delivery_method :test
end

if fixture = ENV['TEST_FIXTURE']
  TEST_FIXTURE = ENV['TEST_FIXTURE']
  puts "Using TEST_FIXTURE=#{TEST_FIXTURE}"
else
  abort "Please run: TEST_FIXTURE=file rake"
end

module RumlTestSupport
  def exec_ruml(arg, input)
    # TODO execute "bin/ruml" directly
    begin
      Ruml.broadcast!(arg, input)
      "" # empty output
    rescue => e
      "#{e.message} (#{e.class})"
    end
  end

  def fixture_path(*name)
    File.join(File.dirname(__FILE__), "fixtures", *name.map(&:to_s))
  end

  def deliveries
    Mail::TestMailer.deliveries
  end

  def example_ml_path
    case TEST_FIXTURE
    when "file"
      fixture_path "example_ml"
    when "yaml", "yml"
      fixture_path "example_ml.yml"
    else
      abort "Unknown TEST_FIXTURE #{TEST_FIXTURE.inspect}"
    end
  end
end

class MiniTest::Test
  include RumlTestSupport

  def setup
    Mail::TestMailer.deliveries.clear
  end
end

module Kernel
  def capture_output
    out = StringIO.new
    $stdout = out
    $stderr = out
    yield
    return out.string
  ensure
    $stdout = STDOUT
    $stdout = STDERR
  end
end
