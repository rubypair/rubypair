class UserModel
  def self.recent_local_users
    User.desc(:created_at).any_in(remote_local_preference: %w[Local Both]).limit(5)

  end

  def self.recent_remote_users
    User.desc(:created_at).any_in(remote_local_preference: %w[Remote Both]).limit(5)
  end

  def self.fulltext_search(args = {})
    User.fulltext_search(args)
  end

  def self.tag_cloud(size = 20)
    interest_histogram
      .sort { |a, b| a[1] <=> b[1] }
      .reverse
      .take(size)
      .sort
  end

  def self.interest_histogram
    User.all.inject(Hash.new(0)) do |hist, u|
      normalize_interests_to_array(u.interests).each do |tag|
        hist[tag] += 1
      end
      hist
    end
  end
  
  private
  def self.normalize_interests_to_array(interests)
    return [] if interests.blank?
    interests.downcase.split(/\s*,\s*,?\s*/)
  end

end
