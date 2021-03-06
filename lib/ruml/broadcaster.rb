require 'mail'

module Ruml
  class Broadcaster
    def initialize(ml, message)
      @ml = ml
      @message = Mail.new(message)
    end

    def valid_member?
      expected = @message.from.size
      actual   = (@message.from.map(&:downcase) & @ml.members.map(&:downcase)).size
      expected == actual
    end

    def been_there?
      @message['X-BeenThere'].to_s == @ml.to
    end

    def add_headers!(mail)
      mail['X-BeenThere'] = @ml.to
      mail['List-Id']     = "<#{@ml.id}>"
      mail['List-Post']   = "<mailto:#{@ml.to}>"
      mail['Precedence']  = 'list'
      mail['Sender']      = @ml.bounce_to
      mail['Errors-To']   = @ml.bounce_to
      mail['User-Agent']  = @message['User-Agent'].value if @message['User-Agent']
    end

    def add_body!(mail)
      if @message.multipart?
        @message.parts.each do |part|
          mail.add_part part
        end
      else
        mail.body @message.body.raw_source
      end
    end

    def from
      @message.from.first
    end

    def to
      @ml.to
    end

    def recipients
      @ml.members
    end

    def subject
      if @ml.name && !@message.subject.include?(@ml.name)
        "#{@ml.name} #{@message.subject}"
      else
        @message.subject
      end
    end

    def broadcastable?
      !been_there? && valid_member?
    end

    def broadcast!
      return unless broadcastable?
      mail = Mail.new
      mail.subject  subject
      mail.from     from
      mail.to       to
      mail.bcc      recipients

      add_headers! mail
      add_body! mail

      mail.deliver
    end
  end
end
