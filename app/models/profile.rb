class Profile
  include Mongoid::Document

  field :interested_in_remote, type: Integer, default: 0
  field :interested_in_local, type: Integer, default: 0

  embedded_in :user
end
