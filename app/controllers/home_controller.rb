class HomeController < ApplicationController
  def index
    @newest_remote_users = User.desc(:created_at).any_in(remote_local_preference: %w[Remote Both]).limit(5)
    @newest_local_users = User.desc(:created_at).any_in(remote_local_preference: %w[Local Both]).limit(5)
  end

  def search
    @results = User.fulltext_search(params[:query])
  end
end
