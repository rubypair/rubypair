module AuthMacros
  def login(user = nil)
    user ||= FactoryGirl.create(:user)
    oauth_mock user
    visit '/auth/github'
  end
  
  def oauth_mock(user)
    data = {
      "extra" => {
        "raw_info" => {
          "login" => user.github_login,
          "gravatar_id" => user.gravatar_id,
          "location" => user.location
        }
      }
    }
    OmniAuth.config.add_mock(:github, data)
  end
end