class HomeController < ApplicationController
  def index
    @newest_remote_users = User.desc(:created_at).where("profile.remote_local_preference".to_sym.in => %w[Remote Both]).limit(5)
    @newest_local_users = User.desc(:created_at).where("profile.remote_local_preference".to_sym.in => %w[Local Both]).limit(5)
  end
end
