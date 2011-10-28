require 'rubygems'
require 'bundler/setup'

require 'minitest/spec'
require 'minitest/autorun'

module RumlTestSupport
  def exec_ruml(arg, input)
    # TODO execute "bin/ruml" directly
    begin
      ml = Ruml.new(arg)
      ml.broadcast!(input)
    rescue => e
      "#{e.message} (#{e.class})"
    end
  end
end

MiniTest::Unit::TestCase.send :include, RumlTestSupport

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
