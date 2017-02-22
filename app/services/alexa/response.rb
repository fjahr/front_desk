class Alexa::Response
  def initialize(request)
    @request = request
  end

  def build
    resp = AlexaRubykit::Response.new

    case intent_name
    when "NotifyArrival"
      # pokemon = Pokemon.order(vote_count: :desc).first

      resp.add_speech('Ruby is running ready!')
      # message = "The hottest pokemon is Sandra Hoang Fabian!"
      # render response_with_message(message)
    else
      resp.add_speech("I can not find the person you are looking for.")
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
