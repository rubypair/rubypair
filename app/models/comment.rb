class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :body, type: String
  field :author, type: BSON::ObjectId
  
  embedded_in :user
  
  def _author
    @author ||= User.find author if author?
  end
end