class Profile
  include Mongoid::Document

  LOCAL_PREFERENCES = ["Local", "Remote", "Both"]

  field :remote_local_preference, type: String, default: "Both"

  embedded_in :user
end
