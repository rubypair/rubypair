class CommentsController < ApplicationController
  before_filter :find_user
  before_filter :find_comment, except: [:create]
  before_filter :authorize_user!, except: [:create]
  
  helper_method :can_delete_comment?
  helper_method :can_edit_comment?
  
  def create    
    if current_user and current_user != @user
      @comment = Comment.new(params[:comment].merge(:author => current_user.id))
      
      if @comment.valid?
        @user.comments.push @comment
        @user.save
        redirect_to @user, :notice => 'Comment posted.'
      else
        render template: 'users/show'
      end
    else
      redirect_to @user, alert: 'You are not able to author comments!'
    end
  end

  def edit
  end
  
  def update
    if @comment.update_attributes(params[:comment])
      redirect_to @user, notice: 'Comment updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @comment.delete
    redirect_to @user, notice: 'Comment deleted.'
  end
  
  private
    def find_user
      @user = User.where("_id" => params[:user_id]).first
    end
    
    def find_comment
      @comment = @user.comments.find(params[:id])
    end
    
    def authorize_user!
      special_right = case params[:action].to_sym
        when :update, :edit then can_edit_comment? @comment
        when :destroy then can_delete_comment? @comment
        else true
      end
      
      if not (current_user and special_right)
        redirect_to @user, alert: 'You are not able to author comments!'
      end
    end
    
    def can_delete_comment?(comment)
      current_user == comment.user or current_user == comment._author
    end
    
    def can_edit_comment?(comment)
      current_user == comment._author
    end
end
