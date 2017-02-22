namespace :alexa do
  desc "Generate Intent Schema"
  task :intents => :environment do
    generator = Alexa::Generator.new
    puts generator.intent_schema.to_json
  end

  desc "Generate Alexa Utterances for notify arrival intent"
  task :utterances => :environment do
    generator = Alexa::Generator.new
    puts generator.sample_utterances(:NotifyArrival)
  end
end
