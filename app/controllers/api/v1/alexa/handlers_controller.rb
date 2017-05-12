class Api::V1::Alexa::HandlersController < ActionController::Base
  prepend_before_action :set_access_token_in_params
  before_action :no_token_catch
  before_action :doorkeeper_authorize!
  respond_to :json

  def create
    render status: 400 unless valid_request

    resp = ::Alexa::Response.new(current_doorkeeper_user.account, params).build

    render json: resp
  end

  def current_doorkeeper_user
    return User.find(6) if Rails.env.development?

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

  def no_token_catch
    unless token_from_params.present?
      resp = ::Alexa::Response.link_account_response
      render json: resp
    end
  end
end
