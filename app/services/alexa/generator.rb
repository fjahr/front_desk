class Alexa::Generator
  def initialize(model = Alexa::FrontDeskInteractionModel.build)
    @model = model
  end

  def sample_utterances(intent)
    @model.sample_utterances(intent)
  end

  def intent_schema
    @model.intent_schema
  end
end
