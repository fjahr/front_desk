class Api::V1::Alexa::HandlersController < ActionController::Base
  prepend_before_action :set_access_token_in_params
  # deactivated for testing
  # before_action :doorkeeper_authorize!
  respond_to :json

  def create
    # deactivated for testing
    # user = current_doorkeeper_user

    resp = AlexaRubykit::Response.new

    case intent_name
    when "NotifyArrival"
      # pokemon = Pokemon.order(vote_count: :desc).first

      resp.add_speech('Ruby is running ready!')
      # message = "The hottest pokemon is Sandra Hoang Fabian!"
      # render response_with_message(message)
    when "LastPokemonVote"
      # pokemon = user.votes.order(created_at: :desc).first.pokemon
      # message = "Your last vote was for #{pokemon.name}"
      # render response_with_message(message)
    else
      resp.add_speech("I can not find the person you are looking for.")
    end

    render json: resp.build_response
  end

  def current_doorkeeper_user
    @current_doorkeeper_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  private

  def intent_name
    params["request"]["intent"]["name"]
  end

  def response_with_message(message)
    {
      json: {
         "response": {
           "outputSpeech": {
             "type": "PlainText",
             "text": message,
           },
           "shouldEndSession": true
         },
         "sessionAttributes": {}
       }
     }
  end

  def set_access_token_in_params
    request.parameters[:access_token] = token_from_params
  end

  def token_from_params
    params["session"]["user"]["accessToken"] rescue nil
  end
end
