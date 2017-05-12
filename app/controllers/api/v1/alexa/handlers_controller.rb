class Api::V1::Alexa::HandlersController < ActionController::Base
  prepend_before_action :set_access_token_in_params
  before_action :doorkeeper_authorize!
  respond_to :json

  def create
    render status: 400 unless valid_request

    if current_doorkeeper_user
      resp = ::Alexa::Response.new(current_doorkeeper_user.account, params).build
    else
      resp = ::Alexa::Response.link_account_response
    end

    render json: resp
  end

  def current_doorkeeper_user
    # return User.find(6) if Rails.env.development?
    return nil unless doorkeeper_token

    @current_doorkeeper_user ||= User.find(doorkeeper_token.resource_owner_id)
  end

  private

  def valid_request
    params["request"].present? && params["session"].present?
  end

  def set_access_token_in_params
    request.parameters[:access_token] = token_from_params
  end

  def token_from_params
    params["session"]["user"]["accessToken"] rescue nil
  end

  def doorkeeper_authorize!
    return if Rails.env.development?

    super
  end
end
