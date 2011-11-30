module ApplicationHelper
  def availability_links
    content_tag(:span) do
      link_to("Mark Available", user_availability_path(current_user), method: :post, class: "available #{availability_css_class(:available)}", remote: true) +
      link_to("Mark Unvailable", user_availability_path(current_user), method: :delete, class: "unavailable #{availability_css_class(:unavailable)}", remote: true)
    end
  end

  def availability_css_class(availability_flag)
    current_user.extend User::Availability
    if (availability_flag == :available && !current_user.available?) ||
       (availability_flag == :unavailable && current_user.available?)
      ""
    else
      "hidden"
    end
  end
end
