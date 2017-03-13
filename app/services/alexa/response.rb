class Alexa::Response
  def initialize(account, request)
    @request = request
    @account = account
  end

  def build
    resp = AlexaRubykit::Response.new

    case intent_type
    when "LAUNCH_REQUEST"
      resp.add_speech('Up to date.')
    when "IntentRequest"
      case intent_name
      when "NotifyArrival"
        visitor_name = slots["VisitorName"]["value"]
        member_name = slots["MemberName"]["value"]

        member = @account.members.find_by(name: member_name)
        unless member.present?
          found_alias = @account.aliases.find_by(name: member_name)
          member = found_alias.member if found_alias.present?
        end

        if member.present?
          notifier = Webhooks::Slack::Notification.new("https://hooks.slack.com/services/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")
          notifier.send(member_name, visitor_name)

          resp.add_speech("Thanks #{visitor_name}. I notified #{member.name} of your arrival.")
        else
          resp.add_speech("Sorry #{visitor_name}. I could not find a member named #{member_name}. Please try a different name.")
        end

        Visit.create(account: @account, member_name: member_name, visitor_name: visitor_name, member: member)
      end
    when "AMAZON.HelpIntent"
      resp.add_speech(
        "Let me know who you are and who you are looking to meet. If you don't know who you want to meet, just say anyone."
      )
    when "SESSION_ENDED_REQUEST"
            # it's over
      #       message = nil
    else
      resp.add_speech('Sorry, something went wrong. Please try again.')
    end

    resp.build_response
  end

  private

  def intent_name
    begin
      @request["intent"]["name"]
    rescue
      raise InvalidRequestError, "No intent or intent name found in request"
    end
  end

  def intent_type
    begin
      @request["type"]
    rescue
      raise InvalidRequestError, "No intent or intent type found in request"
    end
  end

  def slots
    begin
      @request["intent"]["slots"]
    rescue
      raise InvalidRequestError, "No intent or intent slots found in request"
    end
  end
end

class InvalidRequestError < StandardError
end
