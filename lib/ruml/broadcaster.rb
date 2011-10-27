module Ruml
  class Broadcaster
    def initialize(ml, message)
      @ml = ml
      @message = Mail.new(message)
    end

    def sendable?
      !been_there? && valid_member?
    end

    def valid_member?
      expected = @message.from.size
      actual   = (@message.from(&:downvase) & @ml.members.map(&:downcase)).size
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

    def subject
      if @ml.name && !@message.subject.include?(@ml.name)
        "#{@ml.name} #{@message.subject}"
      else
        @message.subject
      end
    end

    def send!
      @ml.members.each do |recipient|
        send_to(recipient)
      end
    end

    def send_to(recipient)
      mail = Mail.new
      mail.subject  subject
      mail.from     from
      mail.to       to
      mail.bcc      recipient

      add_headers! mail
      add_body! mail
      deliver! mail
    end

    def deliver! mail
      if $debug
        puts mail.to_s
      else
        mail.delivery_method :sendmail
        mail.deliver
      end
    end
  end
end
