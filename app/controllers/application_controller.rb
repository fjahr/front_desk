class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
end
