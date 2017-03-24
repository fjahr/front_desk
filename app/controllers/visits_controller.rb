class VisitsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_subscription!

  def index
    @visits = current_account.visits.all.page params[:page]
  end

  def destroy
    current_account.visits.find_by(id: params[:id]).destroy

    redirect_to visits_path
  end
end
