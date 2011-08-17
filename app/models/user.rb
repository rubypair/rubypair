class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,         type: String
  field :github_login, type: String
  field :email,        type: String
  field :github_url,   type: String
  field :blog_url,     type: String
  field :gravatar_id,  type: String
  field :location,     type: String

  embeds_one :profile

  after_create do
    create_profile
  end
end

