class HomeController < ApplicationController
  def index
    @newest_remote_users = UserModel.recent_remote_users
    @newest_local_users = UserModel.recent_local_users
  end

  def search
    @users = UserModel.fulltext_search(params[:query])
  end

  def about
  end
end
