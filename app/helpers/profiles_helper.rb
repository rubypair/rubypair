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
end
