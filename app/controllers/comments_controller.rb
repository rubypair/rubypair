class CommentsController < ApplicationController
  helper_method :can_author_comment?
  
  def create
    @user = User.find(params[:user_id])
    
    if current_user
      @comment = Comment.new(params[:comment].merge(:author => current_user.id))
      
      if @comment.valid?
        @user.comments.push @comment
        @user.save
        redirect_to @user, :notice => 'Comment posted.'
      else
        render template: 'users/show'
      end
    else
      redirect_to @user, :alert => 'You are not able to post comments!'
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    
    unless can_author_comment? @comment
      redirect_to root_url, :alert => 'You are not able to edit comments!'
    end
  end
  
  def update
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    
    if not can_author_comment? @comment
      redirect_to root_url, :alert => 'You are not able to edit comments!'
    elsif @comment.update_attributes(params[:comment])
      redirect_to @user, :notice => 'Comment updated.'
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @comment = @user.comments.find(params[:id])
    
    if can_author_comment? @comment
      @comment.delete
      redirect_to @user, :notice => 'Comment deleted.'
    else
      redirect_to @user, :alert => 'You are not able to delete comments!'
    end
  end
  
  private
  
  def can_author_comment?(comment)
    current_user == comment.user or current_user == comment._author
  end
end
