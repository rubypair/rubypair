class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch

  field :name,                     type: String
  field :github_login,             type: String
  field :email,                    type: String
  field :github_url,               type: String
  field :blog_url,                 type: String
  field :gravatar_id,              type: String
  field :location,                 type: String
  field :remote_local_preference,  type: String, default: "Both"
  field :pairing_toolchain,        type: String
  field :interests,                type: String
  field :twitter,                  type: String
  field :gpl,                      type: Boolean
  field :mit,                      type: Boolean
  field :cc,                       type: Boolean
  field :proprietary,              type: Boolean

  REMOTE_LOCAL_PREFERENCES = ["Local", "Remote", "Both"]

  fulltext_search_in :name, :github_login, :interests

  validates_format_of :twitter,
    on: :update,
    with: /^\w+$/,
    message: "if present must not start with a '@'"
end

