module Ruml
  class Config
    attr_reader :path

    def initialize(path)
      @path = path.to_s

      case @path
      when /\.ya?ml/
        construct PlainYAML, :path => @path
      else
        raise ArgumentError, "Couldn't find mailing list in #{@path.inspect}" unless File.directory?(@path)
        construct Moneta::Adapters::BasicFile, :path => @path
      end
    end

    def [](name)
      @moneta[name]
    end

    def []=(name, value)
      @moneta[name] = value
    end

    def construct(adapater, *args)
      @moneta = Builder.new(adapater.new(*args))
    end

    class Builder
      include Moneta::Middleware

      def initialize(adapater)
        adapater.extend NoSerialization
        build(adapater)
      end
    end

  private

    class PlainYAML < ::Moneta::Adapters::YAML
      def [](key)
        string_key = key_for(key)
        yaml[string_key] if yaml.key?(string_key)
      end

      def store(key, value, *)
        hash = yaml
        hash[key_for(key)] = value
        save(hash)
      end
    end

    module NoSerialization
      def serialize(value)
        value
      end

      def deserialize(value)
        value
      end
    end

  end
end
