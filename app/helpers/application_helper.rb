module ApplicationHelper
  def current_plan
    params[:plan] || "chat_monthly"
  end

  def current_account
    current_user.account
  end
end
