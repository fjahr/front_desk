class SlackNotification
  def initialize(account)
    @client = Slack::Client.new(token: account.slack_token)
  end

  def send(member, visitor_name)
    @client.chat_postMessage(channel: "@#{member}", text: "You have a visitor. #{visitor_name} is waiting for you at the entrance.")
  end

  def send_linking_success(channel)
    @client.chat_postMessage(channel: channel, text: "Front Desk was successfully linked to Slack.")
  end
end
