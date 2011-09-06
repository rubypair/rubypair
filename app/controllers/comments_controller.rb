class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @comment = @user.comments.create(params[:comment].merge(:author => current_user.id))
    
    redirect_to @user
  end

  def edit
  end

  def delete
  end
end
