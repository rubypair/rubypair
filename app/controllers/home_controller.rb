class HomeController < ApplicationController
  def index
    @newest_remote_users = User.desc(:created_at).where("profile.interested_in_remote" => "1").limit(5)
    @newest_local_users = User.desc(:created_at).where("profile.interested_in_local" => "1").limit(5)
  end
end
