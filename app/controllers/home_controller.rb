class HomeController < ActionController::Base
  http_basic_authenticate_with name: "alexa", password: "voice" if Rails.env == 'production'
  protect_from_forgery with: :exception

  layout "home"

  def index
  end
end
