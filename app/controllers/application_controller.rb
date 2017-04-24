class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "alexa", password: "voice" if Rails.env == 'production'
  protect_from_forgery with: :exception
  before_action :set_raven_context

  def current_account
    current_user.account
  end

  def after_sign_in_path_for(resource)
    dashboard_path || request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def authorize_subscription!
    if current_account.never_subscribed?
      redirect_to new_subscription_path, notice: "Please subscribe to access your account."
    elsif current_account.expired?
      redirect_to new_subscription_path, notice: "Please reactivate your subscription to access your account."
    end
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
