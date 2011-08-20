class Profile
  include Mongoid::Document

  field :interested_in_remote, type: Boolean, default: false
  field :interested_in_local, type: Boolean, default: false

  embedded_in :user
end
