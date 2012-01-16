module ApplicationHelper
  def availability_links
    # TODO: Consider embedding haml engine call here so that we can use HAML instead of clusterfuck that is content_tag
    # TODO: Then extract the haml engine call out into a method that takes a string of HAML but handles all of the details of setting up the engine
    content_tag(:span) do
      link_to("Mark Available", user_availability_path(current_user), method: :post, class: "available #{availability_css_class(:available)}", remote: true) +
      link_to("Mark Unavailable", user_availability_path(current_user), method: :delete, class: "unavailable #{availability_css_class(:unavailable)}", remote: true)
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
