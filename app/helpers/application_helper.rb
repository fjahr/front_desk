module ApplicationHelper
  def current_plan
    params[:plan] || "chat_monthly"
  end

  def current_account
    current_user.account
  end

  def active?(path)
    if current_page? path
      "active"
    else
      ""
    end
  end

  def nav_link(name, path)
    content_tag(:li, class: "nav-item #{active?(path)}") do
      link_to name, path, class: "nav-link"
    end
  end
end
