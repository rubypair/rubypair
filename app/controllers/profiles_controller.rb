class ProfilesController < ApplicationController
  before_filter :find_profile

  def show
  end

  def edit
  end

  def update
    params[:user][:profile][:interested_in_remote] = params[:user][:profile][:interested_in_remote] == "1"
    current_user.update_attributes(params[:user])
    flash[:notice] = "Your profile has been updated!"
    redirect_to :root
  end

  private
    def find_profile
      @profile = current_user.profile
    end
end
