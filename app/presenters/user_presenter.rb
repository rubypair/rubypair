require 'delegate'

class UserPresenter < SimpleDelegator
  def initialize(user)
    super user
  end

  def pairing_preference
    case remote_local_preference
    when "Both"
      "Local or Remote"
    else
      remote_local_preference
    end
  end

  def display_twitter?
    twitter && twitter != ""
  end

  def twitter_link
    "http://twitter.com/#{twitter}"
  end

  def github_link
    "http://github.com/#{github_login}"
  end

  def display_location?
    location && location != ""
  end

  def display_email?
    email && email != ""
  end

  def gravatar_image_url(size = 80)
    "http://www.gravatar.com/avatar.php?gravatar_id=#{gravatar_id}&size=#{size}"
  end

  def interest_links
    if interests && interests != ""
      interests.split(",")
               .map { |term| link_to_search_term(term) }
               .join(", ")
               .html_safe
    else
      "No interests. So sad..."
    end
  end

  def link_to_search_term(term)
    "<a href='/search?query=#{term.split(' ' ).map{|x| x.strip}.join('+')}'>#{term}</a>"
  end

  def pairing_preference_options
    User::REMOTE_LOCAL_PREFERENCES.map do |pref|
      case pref
      when "Both"
        ["Local or Remote", pref]
      else
        [pref, pref]
      end
    end
  end
end
