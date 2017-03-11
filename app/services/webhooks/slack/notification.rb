class Webhooks::Slack::Notification
  def initialize(webhook_url)
    @notifier = ::Slack::Notifier.new webhook_url do
      defaults username: "Front Desk",
               icon_url: ""
    end
  end

  def send(member, visitor_name)
    @notifier.ping "You have a visitor. #{visitor_name} is waiting for you at the entrance.", channel: "@#{member}"
  end
end
