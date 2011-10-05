class UserModel
  def self.recent_local_users
    User.desc(:created_at).any_in(remote_local_preference: %w[Local Both]).limit(5)

  end

  def self.recent_remote_users
    User.desc(:created_at).any_in(remote_local_preference: %w[Remote Both]).limit(5)
  end

  def self.fulltext_search(query_string, opts = {})
    User.fulltext_search(query_string, opts)
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
     .reject { |m| m.nil? || m == "" }
     .inject(Hash.new(0)) do |hist, v|
       hist[v] += 1
       hist
     end
  end
end
