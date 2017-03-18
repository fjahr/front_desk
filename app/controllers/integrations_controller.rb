class IntegrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_subscription!

  def index
  end
end
