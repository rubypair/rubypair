require 'spec_helper'

describe User do
  let (:user) { Factory.build(:user) }

  describe "twitter handle" do
    it "copes with a prefixed @-symbol" do
      user.twitter = "@Lenary"
      user.twitter.should == "Lenary"
    end

    it "copes with a space padded handle" do
      user.twitter = " @Lenary "
      user.twitter.should == "Lenary"
    end

    it "copes with no prefixed @-symbol" do
      user.twitter = "Lenary"
      user.twitter.should == "Lenary"
    end

    it "copes with empty strings" do
      user.twitter = ""
      user.twitter.should == ""
    end
  end

  context "availability" do
    describe "When searching for available user" do
      before do
        @not_available = Factory(:user, last_available_time: nil)
        @available = Factory(:user, last_available_time: Time.now)
      end

      it "should only find users with a available mark up time" do
        result = User.available
        result.should include(@available)
        result.should_not include(@not_available)
      end

      context "who have marked available recently" do
        before do
          @available_by_1_sec =
            Factory(:user,
                    last_available_time: Time.now - User::RECENT_AVAILABILILTY_OFFSET + 1.second)
          @available_exactly =
            Factory(:user,
                    last_available_time: Time.now - User::RECENT_AVAILABILILTY_OFFSET)
          @not_available_by_1_sec =
            Factory(:user,
                    last_available_time: Time.now - User::RECENT_AVAILABILILTY_OFFSET - 1.second)
        end

        it "should only find users with a markup time within the recent constraint" do
          result = User.available_recently
          result.should include(@available_by_1_sec)
          result.should include(@available_exactly)
          result.should include(@available)
          result.should_not include(@not_available_by_1_sec)
        end
      end
    end
  end

end
