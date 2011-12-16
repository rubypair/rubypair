class User
  module Availability
    def self.available_users
      User.desc(:last_available_time).
           where(:last_available_time.ne => nil).
           where(:last_available_time.gt => 2.hours.ago).
           limit(5)
    end

    def available!
      self.last_available_time = Time.now
      save!
    end

    def unavailable!
      self.last_available_time = nil
      save!
    end

    def available?
      !!last_available_time
    end
  end
end
