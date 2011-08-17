class Profile
  include Mongoid::Document

  field :interested_in_remote, type: Boolean, default: false

  embedded_in :user
end
