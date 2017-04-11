class Api::V1::Alexa::HandlersController < ActionController::Base
  prepend_before_action :set_access_token_in_params
  # before_action :doorkeeper_authorize!
  respond_to :json

  def create
    user = current_doorkeeper_user
    render status: 401 unless user

    render status: 400 unless params["request"]
    resp = ::Alexa::Response.new(user.account, params["request"])

    render json: resp.build
  end

  def current_doorkeeper_user
    if doorkeeper_token.present?
      @current_doorkeeper_user ||= User.find(doorkeeper_token.resource_owner_id)
    else
      nil
    end
  end

  private

  def set_access_token_in_params
    request.parameters[:access_token] = token_from_params
  end

  def token_from_params
    params["session"]["user"]["accessToken"] rescue nil
  end
end
