require 'rails_helper'

RSpec.describe Alexa::Response do
  let(:req) {
    {"type" => "IntentRequest",
     "requestId" => "EdwRequestId.3c378200-75fa-4876-976a-a5c24d86113b",
     "timestamp" => "2017-02-22T17:28:13Z",
     "locale" => "en-US",
     "intent" => {
       "name" => "NotifyArrival",
       "slots" => {
         "VisitorName" => {
           "name" => "VisitorName",
           "value" => "John Doe"
         },
         "EmployeeName" => {
           "name" => "EmployeeName",
           "value" => "Jane Doe."
         }
       }
     },
     "inDialog" => false
    }
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

  context "of a valid request" do
    it "builds a valid response" do
      expect(subject.build).to eq(
        {"version":"1.0",
         "response":{
            "outputSpeech":{
              "type":"PlainText",
              "text":"Ruby is running ready!"
            },
            "shouldEndSession":true
          }
        }.to_json
      )
    end
  end

end
