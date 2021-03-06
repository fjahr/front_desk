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
      if @account.name.present?
        resp.add_speech("Welcome to #{@account.name}! Who shall I say is here?")
      else
        resp.add_speech('Welcome! Who shall I say is here?')
      end

      @visit.update(state: Visit.states.start)
    when "IntentRequest"
      if (intent_name == "AMAZON.CancelIntent" || intent_name == "AMAZON.StopIntent")
        @visit.update(state: Visit.states.cancel)
        resp.add_speech("Good bye.")
        session_end = true
      elsif (intent_name == "AMAZON.HelpIntent")
        resp.add_speech(
          "Please tell who you are and who you are looking to meet. I will notify the right person for you. If you don't know who you want to meet, just say anyone when asked who you want to meet."
        )
      else
        if intent_name == "NotifyArrival"
          visitor_name = slots["VisitorName"]["value"]
          member_name = slots["MemberName"]["value"]

          if visitor_name.present? && member_name.present?
            member = MemberFinder.find(@account, member_name)

            if member.present?
              notifier = SlackNotification.new(@account)
              notifier.send(member_name, visitor_name)

              resp.add_speech("Thanks #{visitor_name}. I notified #{member.name} of your arrival.")
            else
              resp.add_speech("Sorry, #{visitor_name}. I could not find a member named #{member_name}. Please try a different name.")
            end
          elsif visitor_name.present? && !member_name.present?
            resp.add_speech("Sorry. I did not get who you want to visit. Please try again.")
          elsif !visitor_name.present? && member_name.present?
            resp.add_speech("Sorry. I did not get your name. Please try again.")
          else
            resp.add_speech("Sorry. I did not understand. Please try again.")
          end

          session_end = true
          @visit.update(member_name: member_name, visitor_name: visitor_name, member: member, state: Visit.states.end)
        elsif intent_name == "GiveName" && @visit.state.present?
          case @visit.state
          when Visit.states.start
            visitor_name = slots["Name"]["value"]

            @visit.update(state: Visit.states.visitor_name_given, visitor_name: visitor_name)

            resp.add_speech("Who would you like to see?")
          when Visit.states.visitor_name_given
            member_name = slots["Name"]["value"]

            member = MemberFinder.find(@account, member_name)

            if member.present?
              resp.add_speech("You would like to see #{member.name}. Is that correct?")
              @visit.update(state: Visit.states.member_name_given, member_name: member_name, member: member)
            else
              resp.add_speech("Sorry. I could not find anyone named #{member_name}. Can you say it again, please?")
            end
          when Visit.states.member_name_given
            if intent_name == "AMAZON.YesIntent"
              member = @visit.member

              notifier = SlackNotification.new(@account)
              notifier.send(member.slack_id, @visit.visitor_name)

              resp.add_speech("Thanks #{@visit.visitor_name}. I notified #{member.name} of your arrival.")
              @visit.update(state: Visit.states.end)
              session_end = true
            elsif intent_name == "AMAZON.NoIntent"
              resp.add_speech("Ok, let's try again: who would you like to see?")

              @visit.update(state: Visit.states.visitor_name_given)
            else
              resp.add_speech("I am sorry, something went wrong. Please start again.")
              session_end = true
            end
          end
        else
          resp.add_speech('Sorry, something went wrong. Please try again.')
        end
      end
    when "SessionEndedRequest"
      session_end = true
    else
      resp.add_speech('Sorry, something went wrong. Please try again.')
    end

    resp.build_response(session_end)
  end

  def self.link_account_response
    resp = AlexaRubykit::Response.new
    session_end = true

    resp.add_speech("Please go to your Alexa app and link the skill to your Front Desk account.")
    resp.add_card("LinkAccount")

    resp.build_response(session_end)
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
