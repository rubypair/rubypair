require 'forwardable'

class CommentPresenter
  extend Forwardable
  
  def_delegators :@comment, :body, :_author, :user, :id, :created_at, :errors
  
  def initialize(comment, template)
    @comment, @template = comment, template
  end
  
  def render(&block)
    instance_eval &block
  end
  
  def method_missing(*args, &block)
    @template.send(*args, &block)
  end
  
  def author_name
    if _author == current_user
      "you"
    else
      _author.name
    end
  end
  
  def can_edit?
    user == current_user or _author == current_user
  end
  
  def current_user_gravatar_image_url(size = 40)
    "http://www.gravatar.com/avatar.php?gravatar_id=#{current_user.gravatar_id}&size=#{size}"
  end
  
  def author_gravatar_image_url(size = 40)
    "http://www.gravatar.com/avatar.php?gravatar_id=#{_author.gravatar_id}&size=#{size}"
  end
  
  def comment_path
    user_comment_path(user, id)
  end
  
  def edit_comment_path
    edit_user_comment_path(user, id)
  end
  
  def new_comment_path
    [user || @template.instance_variable_get('@user'), @comment]
  end
    
  def author_path
    user_path(_author)
  end
  
  def created_time_ago
    time_ago_in_words(created_at) + " ago"
  end
end
  