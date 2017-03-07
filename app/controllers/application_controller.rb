class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_account
    current_user.account
  end
end
