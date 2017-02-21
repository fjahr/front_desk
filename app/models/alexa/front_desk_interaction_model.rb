class Alexa::FrontDeskInteractionModel
  def self.build
    AlexaGenerator::InteractionModel.build do |model|
      model.add_intent(:NotifyArrival) do |intent|
        intent.add_slot(:Sign, AlexaGenerator::Slot::SlotType::LITERAL) do |slot|
          slot.add_bindings(*%w{Aries Taurus Gemini Cancer Leo Virgo Libra Scorpio Sagittarius Capricorn Aquarius Pisces})
        end

        intent.add_slot(:Date, AlexaGenerator::Slot::SlotType::DATE) do |slot|
          slot.add_bindings('today', 'next Thursday', 'tomorrow')
        end

        intent.add_utterance_template('what is the horoscope for {Sign}')
        intent.add_utterance_template('what will the horoscope for {Sign} be {Date}')
      end
    end
  end
end
