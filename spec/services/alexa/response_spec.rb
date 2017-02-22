require 'rails_helper'

RSpec.describe Alexa::Response do
  let(:req) {
    {}
  }

  subject { Alexa::Response.new(req) }

  context "of a invalid request" do
    let(:req) {
      {}
    }

    it "throws an exception" do
      expect { subject.build }.to raise_error(InvalidRequestError)
    end
  end
end
