class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::FullTextSearch

  include Availability

  REMOTE_LOCAL_PREFERENCES = ["Local", "Remote", "Both"]
  RECENT_AVAILABILILTY_OFFSET = 2.hours

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
  field :last_available_time,      type: Time

  scope :available, where(:last_available_time.ne => nil).desc(:last_available_time)
  scope :available_recently, available.where(:last_available_time.gt => Time.now - RECENT_AVAILABILILTY_OFFSET)

  fulltext_search_in :name, :github_login, :interests, :location

  # This Normalizes twitter handles - strips and matches them
  def twitter=(handle)
    super(handle.strip.sub(/@/, ''))
  end
end

