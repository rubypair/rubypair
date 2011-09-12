require 'coderwall'
class UsersController < ApplicationController
  before_filter :find_user
  before_filter :authorize_user!, :except => :show

  def show
    @coderwall = CoderWall.achievements_of(User.find(params[:id]).github_login)
  end

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:notice] = "Your profile has been updated!"
      redirect_to :root
    else
      render :edit
    end
  end

  private
    def find_user
      @user = User.where("_id" => params[:id]).first
    end

    def authorize_user!
      if current_user != @user
        render text: "Tsk tsk tsk!", status: 403
        false
      end
    end
end
