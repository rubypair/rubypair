class SessionsController < ApplicationController
  def create
    user_info = request.env['omniauth.auth']['user_info']
    user_hash = request.env['omniauth.auth']['extra']['user_hash']

    user = find_or_create_from_oauth_data(user_info, user_hash)

    session[:github_login] = user.github_login

    flash[:notice] = "You have successfully signed in!"

    redirect_to user.kind_of?(NewUserProvisioner) ? edit_user_path(user.id) : :root
  end

  def destroy
    session[:github_login] = nil
    redirect_to :root
  end

  private

  def find_or_create_from_oauth_data(user_info, user_hash)
    login = user_hash['login']
    user = User.where(github_login: login).first
    unless user
      user = User.new
      user.extend NewUserProvisioner
      user.provision_with(user_info, user_hash)
      user.save!
    end
    user
  end
end
