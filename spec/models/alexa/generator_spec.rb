require 'rails_helper'

RSpec.describe Alexa::Generator do
  let(:model) {
    AlexaGenerator::InteractionModel.build do |model|
      model.add_intent(:GetHoroscope) do |intent|
        intent.add_slot(:Sign, AlexaGenerator::Slot::SlotType::LITERAL) do |slot|
          slot.add_bindings(*%w{Aries Taurus})
        end

        intent.add_utterance_template('what is the horoscope for {Sign}')
      end
    end
  }

  subject { Alexa::Generator.new(model) }

  it "generates sample utterances for a intent" do
    expect(subject.sample_utterances(:GetHoroscope)).to eq(
      [
        "GetHoroscope what is the horoscope for {Aries|Sign}",
        "GetHoroscope what is the horoscope for {Taurus|Sign}"
      ]
    )
  end

  it "generates an intent schema" do
    expect(subject.intent_schema).to eq(
      {:intents=>
        [
          {:intent=>:GetHoroscope,
           :slots=>
             [
               {:name=>:Sign,
                :type=>:"AMAZON.LITERAL"}
             ]
          }
        ]
      }
    )
  end
end
