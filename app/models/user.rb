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
  field :latlong,                  type: Array

  REMOTE_LOCAL_PREFERENCES = ["Local", "Remote", "Both"]

  fulltext_search_in :name, :github_login, :interests, :location

  # This Normalizes twitter handles - strips and matches them
  def twitter=(handle)
    super(handle.strip.sub(/@/, ''))
  end
end

