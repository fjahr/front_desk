class SlackImporter
  def initialize(account)
    @account = account
    @client = Slack::Web::Client.new(token: account.slack_token)
  end

  def run
    import_slack_team_members
    add_account_name
  end

  private

  def add_account_name
    resp = @client.team_info
    team = resp["team"]

    unless @account.name.present?
      @account.name = team["name"]
      @account.save
    end
  end

  def import_slack_team_members
    resp = @client.users_list
    members = resp["members"]

    members.each do |member|
      import_member(member) unless is_bot?(member)
    end
  end

  def is_bot?(member)
    member["is_bot"] == true || member["id"] == "USLACKBOT"
  end

  def import_member(member)
    m = @account.members.find_or_initialize_by(slack_id: member["name"])
    unless m.persisted?
      m.name = member["profile"]["real_name"]
      m.email = member["profile"]["email"]
      m.phone = member["profile"]["phone"]
      m.save
    end
  end
end
