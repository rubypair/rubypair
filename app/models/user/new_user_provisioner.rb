module NewUserProvisioner
  def provision_with(user_info, extra_user_hash)
    self.github_login = extra_user_hash['login']
    self.name = user_info['name']
    self.email = user_info['email']
    self.github_url = user_info['urls']['GitHub']
    self.blog_url = user_info['urls']['Blog']
    self.gravatar_id = extra_user_hash['gravatar_id']
    self.location = extra_user_hash['location']
  end
end


				
