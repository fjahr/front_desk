class Alexa::Response
  def initialize(request)
    @request = request
  end

  def build
    resp = AlexaRubykit::Response.new

    case intent_name
    when "NotifyArrival"
      resp.add_speech('Implement me')
    when "AMAZON.HelpIntent"
      resp.add_speech(
        "Let me know who you are and who you are looking to meet. If you don't know who you want to meet, just say anyone."
      )
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
end

class InvalidRequestError < StandardError
end
