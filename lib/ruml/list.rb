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
      @name ||= lines("name").first
    end

    def members
      @members ||= lines("members").map(&:downcase).uniq.reject { |member| member =~ /^#|^$/ }
    end

    def to
      @to ||= lines("to").first
    end

    def bounce_to
      @bounce_to ||= lines("bounce_to").first || to
    end

  private

    def lines(name)
      value = config[name]
      value = value.split("\n").map(&:strip) if value.respond_to?(:split)
      value
    end

  end
end
