class VisitsController < ApplicationController
  before_action :authenticate_user!

  def index
    @visits = current_account.visits.all
  end
end
