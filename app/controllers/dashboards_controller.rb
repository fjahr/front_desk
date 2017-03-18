class DashboardsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :authorize_subscription!

  def show
  end
end
