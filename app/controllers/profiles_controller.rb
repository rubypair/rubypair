class ProfilesController < ApplicationController
  before_filter :find_profile
  before_filter :authorize_user!, :except => :show

  def show
  end

  def edit
  end

  def update
    current_user.update_attributes(params[:user])
    flash[:notice] = "Your profile has been updated!"
    redirect_to :root
  end

  private
    def find_profile
      @user = User.where("profile._id" => params[:id]).first
      @profile = @user.try(:profile)
    end

    def authorize_user!
      if current_user != @user
        render text: "Tsk tsk tsk!", status: 403
        false
      end
    end
end
