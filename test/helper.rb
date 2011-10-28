require 'rubygems'
require 'bundler/setup'

require 'minitest/spec'
require 'minitest/autorun'

require 'ruml'

Mail.defaults do
  delivery_method :test
end

module RumlTestSupport
  def exec_ruml(arg, input)
    # TODO execute "bin/ruml" directly
    begin
      ml = Ruml.new(arg)
      ml.broadcast!(input)
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
    fixture_path "example_ml"
  end
end

MiniTest::Unit::TestCase.send :include, RumlTestSupport

MiniTest::Unit::TestCase.add_setup_hook do
  Mail::TestMailer.deliveries.clear
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
