$LOAD_PATH << "."

require 'ostruct'
require 'timecop'

require 'app/models/user/availability'

describe Availability do
  subject do
    OpenStruct.new.tap do |user|
      user.extend Availability
      user.stub(:save! => true)
    end
  end

  describe "When a user marks up as available" do
    before do
      Timecop.freeze
      subject.available!
    end

    after { Timecop.return }

    its(:last_available_time) { should == Time.now }
  end

  describe "When a user marks up as unavailable" do
    before do
      subject.last_available_time = Time.now
      subject.unavailable!
    end

    its(:last_available_time) { should be_nil }
  end
end
