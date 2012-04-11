$LOAD_PATH << "."

require 'ostruct'
require 'timecop'

require 'app/models/user/availability'


describe User::Availability do
  subject do
    OpenStruct.new.tap do |user|
      user.extend User::Availability
      user.stub(:save! => true)
    end
  end

  describe "When a user marks up as available" do
    before do
      subject.available!
    end

    its(:last_available_time) { should_not be_nil }
  end

  describe "When a user marks up as unavailable" do
    before do
      subject.last_available_time = Time.now
      subject.unavailable!
    end

    its(:last_available_time) { should be_nil }
  end

  describe "When searching for available users" do
    let(:available) {
      Factory(:user, last_available_time: Time.now)
    }

    let(:never_available) {
      Factory(:user, last_available_time: nil)
    }

    it "should only find users with a available mark up time" do
      Timecop.freeze(Time.now) do
        result = User::Availability.ever_been_available
        result.should include(available)
        result.should_not include(never_available)
      end
    end

    context "who have marked available recently" do
      let(:available_by_1_sec) {
        Factory(:user, last_available_time: User::Availability.currently_available_offset + 1.second)
      }

      let(:available_exactly) {
        Factory(:user, last_available_time: User::Availability.currently_available_offset)
      }

      let(:not_available_by_1_sec) {
        Factory(:user, last_available_time: User::Availability.currently_available_offset - 1.second)
      }

      it "should only find users with a markup time within the recent constraint" do
        Timecop.freeze(Time.now) do
          result = User::Availability.currently_available
          result.should include(available_by_1_sec)
          result.should include(available_exactly)
          result.should include(available)
          result.should_not include(not_available_by_1_sec)
        end
      end
    end
  end
end
