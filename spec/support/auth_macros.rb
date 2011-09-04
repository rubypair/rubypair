module AuthMacros
  def login(user = nil)
    user ||= Factory(:user)
    oauth_mock user
    visit '/auth/github'
  end
  
  def oauth_mock(user)
    data = {
      "extra" => {
        "user_hash" => {
          "login" => user.github_login,
          "gravatar_id" => user.gravatar_id,
          "location" => user.location
        }
      }
    }
    OmniAuth.config.add_mock(:github, data)
  end
end