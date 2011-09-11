class UsersController < ApplicationController
  before_filter :find_user,       :except => [:map, :near_me]
  before_filter :authorize_user!, :except => [:map, :near_me, :show]
  before_filter :ensure_user!,    :only => [:near_me]

  def map
    users = User.all
    @map = MapPresenter.new(users)
  end

  def near_me
    users = UserModel.near(current_user.latlong)
    @map = MapPresenter.new(users)
  end

  def show
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

    def ensure_user!
      unless current_user
        render text: "Tsk tsk tsk!", status: 403
        false
      end
    end
end
