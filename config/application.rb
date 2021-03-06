require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FrontDesk
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Raven.configure do |config|
      config.dsn = 'https://ab593a1ce5f74cd68cd4a8562238eaa5:22d502fbfa524cae9e99f86f5f1babdb@sentry.io/157388'
      config.environments = ['staging', 'production']
      config.silence_ready = true
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    config.autoload_paths << "#{Rails.root}/lib"
  end
end
