class VisitsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_subscription!

  def index
    @visits = current_account.visits.all.page params[:page]
  end
end
