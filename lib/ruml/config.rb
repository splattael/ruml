module Ruml
  class Config
    attr_reader :path

    def initialize(path)
      @path = path.to_s
      raise ArgumentError, "Couldn't find mailing list in #{@path.inspect}" unless File.directory?(@path)
    end

    def [](name)
      readlines(name)
    end

  private

    def readlines(name)
      path = File.join(@path, name)
      File.readlines(path).map(&:strip)
    rescue Errno::ENOENT
      []
    end

  end
end
