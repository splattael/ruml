require 'helper'

describe "Ruml binary" do
  it "fails with ArgumentError using empty list path" do
    output = exec_ruml nil, nil
    output.must_match "Couldn't find mailing list in \"\""
    output.must_match "ArgumentError"
  end

  it "fails with ArgumentError using invalid list path" do
    output = exec_ruml "invalid path", nil
    output.must_match "Couldn't find mailing list in \"invalid path\""
    output.must_match "ArgumentError"
  end

  it "fails with NoMethodError on empty input" do
    output = exec_ruml example_ml_path, nil
    output.must_match %r{undefined method `size' (for|on) nil:NilClass}
    output.must_match "NoMethodError"
  end

  describe "with example_ml" do
    let(:mailing_list) { Ruml::List.new(example_ml_path) }

    it "refuse email from unknown member" do
      mail = compose_mail(mailing_list, :from => "unknown@member.com")
      output = exec_ruml mailing_list.path, mail.to_s
      output.must_be_empty
      deliveries.must_be_empty
    end

    describe "from valid member" do
      let(:mail) { compose_mail(mailing_list) }
      let(:output) { exec_ruml mailing_list.path, mail.to_s }
      let(:delivery) { output; deliveries.first }

      it "output is empty" do
        output.must_be_empty
      end

      it "delivers to mailing list & its members" do
        k = (mailing_list.members + [ mailing_list.to ]).sort
        delivery.destinations.sort.must_equal k
        deliveries.size.must_equal 1
      end

      it "contains valid headers" do
        delivery.subject.must_include mailing_list.name
        delivery.subject.must_include mail.subject
        delivery.from.must_equal mail.from
        delivery.to.must_equal [ mailing_list.to ]
      end

      it "contains valid extra headers" do
        delivery['X-BeenThere'].value.must_equal mailing_list.to
        delivery['List-Id'].value.must_include mailing_list.id
        delivery['List-Post'].value.must_include "mailto:"
        delivery['List-Post'].value.must_include mailing_list.to
        delivery['Sender'].value.must_equal mailing_list.bounce_to
        delivery['Errors-To'].value.must_equal mailing_list.bounce_to
      end

      #it "contains users agent" do
      #end

      it "contains correct body" do
        delivery.body.encoded.must_equal mail.body.encoded
      end
    end
  end

  private

  def compose_mail(ml, options={}, &block)
    defaults = {
      :from     => ml.members.first,
      :to       => ml.to,
      :subject  => "Some subject",
      :body     => "some body"
    }
    Mail.new(defaults.merge(options), &block)
  end
end
