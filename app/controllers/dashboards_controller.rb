class DashboardsController < InheritedResources::Base
  before_action :authenticate_user!

  def show
  end
end
