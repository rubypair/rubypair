module ProfilesHelper
  def link_terms_to_search(term)
    link_to term, :controller => "home", :action => "search", :utf8 =>  "&x2713;", :query => "#{term.split(" ").map{|x| x.strip}.join("+")}"
  end
end
