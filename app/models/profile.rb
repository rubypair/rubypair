class Profile
  include Mongoid::Document

  LOCAL_PREFERENCES = ["Local", "Remote", "Both"]

  field :remote_local_preference, type: String, default: "Both"
  field :interests, type: String

  embedded_in :user
end
