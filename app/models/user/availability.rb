class User
  module Availability

    def self.currently_available_offset
      2.hours.ago
    end

    def self.ever_been_available
      User.desc(:last_avaiable_time).
           where(:last_available_time.ne => nil)
    end

    def self.currently_available
      ever_been_available.
           where(:last_available_time.gte => currently_available_offset)
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
