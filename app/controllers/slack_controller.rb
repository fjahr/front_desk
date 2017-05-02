class SlackController < ApplicationController
  def oauth_callback
    code = params[:code]

    client = Rails.application.secrets.slack_client
    # regenerate an put into env variables before production
    secret = Rails.application.secrets.slack_secret

    redirect = SlackImporter.redirect_uri

    response = ::HTTParty.get("https://slack.com/api/oauth.access?client_id=#{client}&client_secret=#{secret}&code=#{code}&redirect_uri=#{redirect}")

    webhook_url = response["incoming_webhook"]["url"]
    channel = response["incoming_webhook"]["channel"]
    token = response["access_token"]

    current_account.update(slack_token: token, slack_webhook: webhook_url)
    importer = SlackImporter.new(current_account)
    importer.run

    notifier = SlackNotification.new(current_account)
    notifier.send_linking_success(channel)

    redirect_to integrations_path, notice: "Front Desk was successfully linked to Slack!"
  end
end
