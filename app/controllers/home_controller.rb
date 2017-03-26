class HomeController < ActionController::Base
  protect_from_forgery with: :exception

  layout "home"

  def index

  end
end
