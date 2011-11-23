module Ruml
  class List
    attr_reader :config

    def initialize(path)
      @config = Config.new(path)
    end

    def path
      config.path
    end

    def id
      @id ||= to.gsub('@', '.')
    end

    def name
      @name ||= ("name").first
    end

    def members
      @members ||= config["members"].map(&:downcase).uniq.reject { |member| member =~ /^#|^$/ }
    end

    def to
      @to ||= config["to"].first
    end

    def bounce_to
      @bounce_to ||= config["bounce_to"].first || to
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
  end
end
