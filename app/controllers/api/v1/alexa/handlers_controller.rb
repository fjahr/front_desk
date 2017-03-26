class Api::V1::Alexa::HandlersController < ActionController::Base
  protect_from_forgery with: :exception

  prepend_before_action :set_access_token_in_params
  # before_action :doorkeeper_authorize!
  respond_to :json

  def create
    # user = current_doorkeeper_user
    # render status: 401 unless user

    render status: 400 unless params["request"]
    # resp = ::Alexa::Response.new(user.account, params["request"])
    # auth hardcoded for testing with the alexa test env
    resp = ::Alexa::Response.new(Account.last, params)

    render json: resp.build
  end

  def current_doorkeeper_user
    @current_doorkeeper_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  private

  def set_access_token_in_params
    request.parameters[:access_token] = token_from_params
  end

  def token_from_params
    params["session"]["user"]["accessToken"] rescue nil
  end
end
