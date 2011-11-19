module ApplicationHelper
  def availability_link
    link_text, link_method = if current_user.available?
      ["Available", :delete]
    else
      ["Unavailable", :post]
    end
    link_to link_text, user_availability_path(current_user), method: link_method, class: :availability, remote: true
  end
end
