module Ruml
  class List
    attr_reader :name

    def initialize(dir)
      @dir = dir
      raise "Unknown ml #{name} (#{@dir})" unless File.directory?(@dir)
    end

    def id
      @id ||= to.gsub('@', '.')
    end

    def name
      @name ||= readlines("name").first
    end

    def members
      @members ||= readlines("members").reject { |member| member =~ /^#|^$/ }
    end

    def to
      @to ||= readlines("to").first
    end

    def bounce_to
      @bounce_to ||= readlines("bounce_to").first || to
    end

    def broadcaster(body)
      Broadcaster.new(self, body)
    end

    def broadcast!(body)
      message = broadcaster(body)
      if message.sendable?
        message.send!
      end
    end

  private

    def readlines(name)
      path = File.join(@dir, name)
      File.readlines(path).map(&:strip)
    rescue Errno::ENOENT
      []
    end
  end
end
