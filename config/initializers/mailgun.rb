Mailgun.configure do |config|
  config.api_key = Rails.application.secrets.mailgun_api_key
end
