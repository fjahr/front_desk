class VisitsController < ApplicationController

  def index
    @visits = current_account.visits.all
  end
end
