class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.create(params[:comment].merge(:author => current_user.id))
    
    redirect_to @user
  end

  def edit
  end

  def destroy
    @user = User.find(params[:user_id])
    @user.comments.find(params[:id]).delete
    
    flash[:notice] = "Deleted comment."
    
    redirect_to @user
  end
end
