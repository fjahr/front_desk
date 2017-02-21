namespace :alexa do
  desc "Generate Intent Schema"
  task :intents => :environment do
    generator = Alexa::Generator.new
    generator.utterances
  end

  desc "Generate Alexa Utterances"
  task :utterances => :environment do
    generator = Alexa::Generator.new
    generator.utterances
  end
end
