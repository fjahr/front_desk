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
    content_tag(:li, class: "nav-item px-1 #{active?(path)}") do
      link_to name, path, class: "nav-link"
    end
  end


  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end
end
