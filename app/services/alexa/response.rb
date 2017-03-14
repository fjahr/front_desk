class Alexa::Response
  def initialize(account, params)
    @request = params["request"]
    @account = account
    @visit = Visit.find_or_initialize_by(account: @account, alexa_session: params["session"]["sessionId"])
  end

  def build
    resp = AlexaRubykit::Response.new
    session_end = false

    case intent_type
    when "LaunchRequest"
      resp.add_speech('Welcome! Please tell me your name.')
      @visit.update(state: Visit.states.start)
    when "IntentRequest"
      if @visit.state.present?
        case @visit.state
        when Visit.states.start
          visitor_name = slots["Name"]["value"]
          @visit.update(state: Visit.states.visitor_name_given, visitor_name: visitor_name)
          resp.add_speech("Who would you like to see?")
        when Visit.states.visitor_name_given
          member_name = slots["Name"]["value"]

          member = find_member(member_name)

          if member.present?
            resp.add_speech("Is #{member.name} the right person?")
            @visit.update(state: Visit.states.member_name_given, member_name: member_name, member: member)
          else
            resp.add_speech("Sorry. I could not find anyone named #{member_name}. Can you say it again, please?")
          end
        when Visit.states.member_name_given
          if intent_name == "AMAZON.YesIntent"
            member = @visit.member

            notifier = Webhooks::Slack::Notification.new("https://hooks.slack.com/services/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")
            notifier.send(member.slack_id, @visit.visitor_name)

            resp.add_speech("Thanks #{@visit.visitor_name}. I notified #{member.name} of your arrival.")
            @visit.update(state: Visit.states.end)
          elsif intent_name == "AMAZON.YesIntent"

          else

          end
        end
      else
        case intent_name
        when "NotifyArrival"
          visitor_name = slots["VisitorName"]["value"]
          member_name = slots["MemberName"]["value"]

          member = find_member(member_name)

          if member.present?
            notifier = Webhooks::Slack::Notification.new("https://hooks.slack.com/services/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")
            notifier.send(member_name, visitor_name)

            resp.add_speech("Thanks #{visitor_name}. I notified #{member.name} of your arrival.")
          else
            resp.add_speech("Sorry #{visitor_name}. I could not find a member named #{member_name}. Please try a different name.")
          end

          session_end = true
          @visit.update(member_name: member_name, visitor_name: visitor_name, member: member, state: Visit.states.end)
        end
      end
    when "AMAZON.HelpIntent"
      resp.add_speech(
        "Let me know who you are and who you are looking to meet. If you don't know who you want to meet, just say anyone."
      )
    when "SessionEndedRequest"
      session_end = true
    else
      resp.add_speech('Sorry, something went wrong. Please try again.')
    end

    resp.build_response(session_end)
  end

  private

  def find_member(member_name)
    member = @account.members.find_by(name: member_name)
    unless member.present?
      found_alias = @account.aliases.find_by(name: member_name)
      member = found_alias.member if found_alias.present?
    end
    member
  end

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
