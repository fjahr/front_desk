require 'rails_helper'

RSpec.describe Alexa::Response do
  let(:user) { FactoryGirl.create(:user) }
  let(:account) { FactoryGirl.create(:account, user: user) }

  let(:params) {
    {
      "session"=>
        {"new"=>true,
         "sessionId"=>"SessionId.28459017-9090-4ebb-ba6b-0cbb0ad113b4",
         "application"=>
           {"applicationId"=>"amzn1.ask.skill.ae5b4662-b03b-4622-86e0-4547b16318bd"},
         "attributes"=>{},
         "user"=>
           {"userId"=>"amzn1.ask.account.AFHUMJVEKHM4WP4R4WWJSRLQQBEWYE7VRF6J26YUEAJAD7OZ3PT6FN7PGQ57UNKTIH3U5U7PJTTBBFLHWP5HZH6NHWZRKZJGPL75CN2WN5S5B5U7M7GSNBPHDEDQZMU2SZZELAP2U2R5Z3Z7G7UDFSMAGSQ5APJTTOZYYCUWDLLTHK5BSFCXJWAM3752YEINZ4UYC2NQZM3FBGQ"}},
      "request" =>
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
             "MemberName" => {
               "name" => "MemberName",
               "value" => "Jane Doe"
             }
           }
         },
         "inDialog" => false
        }
  }
  }

  subject { Alexa::Response.new(account, params) }

  context "of a invalid request" do
    let(:params) {
      {}
    }

    it "throws an exception" do
      expect { subject.build }.to raise_error(InvalidRequestError)
    end
  end

  context "of a valid request" do
    it "builds a valid response" do
      expect(subject.build).to eq(
        {"version": "1.0",
         "response":{
          "outputSpeech":
          {"type": "PlainText",
           "text": "Sorry, John Doe. I could not find a member named Jane Doe. Please try a different name."
        },
        "shouldEndSession": true
        }}.to_json
      )
    end
  end

  context "cancel request" do
    let(:params) {
      {
        "session"=> {
          "sessionId"=> "SessionId.ef053707-24d3-4242-b958-cdd023c18fe2",
          "application"=> {
            "applicationId"=> "amzn1.ask.skill.ae5b4662-b03b-4622-86e0-4547b16318bd"
          },
          "attributes"=> {},
          "user"=> {
            "userId"=> "amzn1.ask.account.AFHUMJVEKHM4WP4R4WWJSRLQQBEWYE7VRF6J26YUEAJAD7OZ3PT6FN7PGQ57UNKTIH3U5U7PJTTBBFLHWP5HZH6NHWZRKZJGPL75CN2WN5S5B5U7M7GSNBPHDEDQZMU2SZZELAP2U2R5Z3Z7G7UDFSMAGSQ5APJTTOZYYCUWDLLTHK5BSFCXJWAM3752YEINZ4UYC2NQZM3FBGQ"
          },
          "new"=> true
        },
        "request"=> {
          "type"=> "IntentRequest",
          "requestId"=> "EdwRequestId.e97b568e-bd03-43c8-a04a-137ba0b813ac",
          "locale"=> "en-US",
          "timestamp"=> "2017-04-11T13:42:52Z",
          "intent"=> {
            "name"=> "AMAZON.StopIntent",
            "slots"=> {}
          }
        },
        "version"=> "1.0"
      }
    }

    it "answers with good bye and ends session" do
      expect(subject.build).to eq(
        {"version": "1.0",
         "response":{
          "outputSpeech":
          {"type": "PlainText",
           "text": "Good bye."
        },
        "shouldEndSession": true
        }}.to_json
      )
    end
  end

end
