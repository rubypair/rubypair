module ProfilesHelper
  def link_terms_to_search(term)
    link_to term, :controller => "home", :action => "search", :utf8 =>  "&x2713;", :query => "#{term.split(" ").map{|x| x.strip}.join("+")}"
  end

  def monkey_slap_preferences(pref)
    case pref
    when "Both"
      "Local or Remote"
    else
      pref
    end
  end
  
  def gravatar_image(user, klass = :gravatar, size = 80)
    image_tag "http://www.gravatar.com/avatar.php?gravatar_id=#{user.gravatar_id}&size=#{size}", :class => klass
  end
  
  def twitter_url(user)
    link_to user.twitter, "http://twitter.com/#{user.twitter}"
  end
  
  def github_url(user)
    link_to user.github_login, "http://github.com/#{user.github_login}"
  end
end
