module Availability
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
