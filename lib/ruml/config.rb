require 'moneta'

module Ruml
  class Config
    attr_reader :path

    def initialize(path)
      @path = path.to_s

      case @path
      when /\.ya?ml/
        construct Moneta::Adapters::YAML, :file => @path
      else
        raise ArgumentError, "Couldn't find mailing list in #{@path.inspect}" unless File.directory?(@path)
        construct Moneta::Adapters::File, :dir => @path
      end
    end

    def [](name)
      @moneta[name]
    end

    def []=(name, value)
      @moneta[name] = value
    end

    def construct(adapter, *args)
      @moneta = Moneta.build do
        use adapter, *args
      end
    end
  end
end
