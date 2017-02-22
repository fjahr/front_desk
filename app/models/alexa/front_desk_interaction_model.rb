class Alexa::FrontDeskInteractionModel
  def self.build
    AlexaGenerator::InteractionModel.build do |model|
      model.add_intent(:NotifyArrival) do |intent|
        intent.add_slot(:EmployeeName, AlexaGenerator::Slot::SlotType::LITERAL)
        intent.add_slot(:VisitorName, AlexaGenerator::Slot::SlotType::LITERAL)

        intent.add_utterance_template('that {John Doe|VisitorName} is here to see {John Doe|EmployeeName}')
        intent.add_utterance_template('to tell {John Doe|EmployeeName} that {John Doe|VisitorName} is here to see her')
        intent.add_utterance_template('to tell {John Doe|EmployeeName} that {John Doe|VisitorName} is here to see him')
        intent.add_utterance_template('to tell {John Doe|EmployeeName} that {John Doe|VisitorName} is here')
      end
    end
  end
end
