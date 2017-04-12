class SlackController < ApplicationController
  def oauth_callback
    code = params[:code]

    client = "146802301377.152576575970"
    # regenerate an put into env variables before production
    secret = "492419298a0e1bebc96af06b7aac8497"
    response = ::HTTParty.get("https://slack.com/api/oauth.access?client_id=#{client}&client_secret=#{secret}&code=#{code}&redirect_uri=https://staging.alexafrontdesk.com/webhooks/slack/oauth_callback")

    webhook_url = response["incoming_webhook"]["url"]
    channel = response["incoming_webhook"]["channel"]
    token = response["access_token"]

    current_account.update(slack_token: token, slack_webhook: webhook_url)
    importer = SlackImporter.new(current_account)
    importer.run

    notifier = SlackNotification.new(current_account)
    notifier.send_linking_success(channel)

    redirect_to integrations_path, notice: "successfully linked to slack!"
  end
end
