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
    if handle.strip =~ /^@(\w+)$/
      super($1)
    else
      super handle.strip
    end
  end

  def self.tag_cloud(size = 20)
    interest_histogram
      .sort { |a, b| a[1] <=> b[1] }
      .reverse
      .take(size)
      .sort
  end

  def self.interest_histogram
    User.all.map { |u|
      u.interests.downcase if u.interests
    }.flatten
     .join(",")
     .split(",")
     .map(&:strip)
     .reject { |m| m.blank? }
     .inject(Hash.new(0)) do |hist, v|
       hist[v] += 1
       hist
     end
  end
end

