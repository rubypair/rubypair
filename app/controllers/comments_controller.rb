class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    
    if current_user
      @comment = @user.comments.create(params[:comment].merge(:author => current_user.id))
      redirect_to @user, :notice => 'Comment posted.'
    else
      redirect_to @user, :alert => 'You are not able to post comments!'
    end
  end

  def edit
  end

  def destroy
    @user = User.find(params[:user_id])
    
    if current_user == @user
      @user.comments.find(params[:id]).delete
      redirect_to @user, :notice => 'Comment deleted.'
    else
      redirect_to @user, :alert => 'You are not able to delete comments!'
    end
  end
end
