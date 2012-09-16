if ENV['LOAD_RAILS'] == '1'
  require 'spec_helper'
else
  $LOAD_PATH << "."
end

require 'app/domain_models/user_model'

class User; end

describe UserModel do
  context "#interest_histogram" do
    before do
      users = ["foo, bar, blech", "foo, Blech, foobar"].map do |interests|
        stub(:user, interests: interests)
      end
      User.stub(:all).and_return(users)
    end

    it "should generate a Hash counting the hits per reference" do
      expected = {
        "foo" => 2,
        "blech" => 2,
        "bar" => 1,
        "foobar" => 1,
      }

      UserModel.interest_histogram.should == expected
    end

    it "should generate a tag cloud containing the N most popular" do
      expecteds = [
        ["blech", 2],
        ["foo", 2],
        ["bar", 1]
      ]

      cloud = UserModel.tag_cloud 3

      expecteds.each do |expected|
        cloud.should include(expected)
      end
    end

    it "should return the tag cloud sorted by tag name" do
      expected = [
        ["bar", 1],
        ["blech", 2],
        ["foo", 2]
      ]

      UserModel.tag_cloud(3).should == expected
    end
  end

  describe "When searching for available users" do
    it "should only find users with a available mark up time" do
      Timecop.freeze(Time.now) do
        available = FactoryGirl.create(:user, last_available_time: Time.now)
        never_available = FactoryGirl.create(:user, last_available_time: nil)

        result = UserModel.ever_been_available
        result.should include(available)
        result.should_not include(never_available)
      end
    end

    context "who have marked available recently" do
      before do
        Timecop.freeze(Time.now)
        @available_by_1_sec =
          FactoryGirl.create(:user, last_available_time: UserModel.currently_available_offset + 1.second)
        @available_exactly =
          FactoryGirl.create(:user, last_available_time: UserModel.currently_available_offset)
        @not_available_by_1_sec =
          FactoryGirl.create(:user, last_available_time: UserModel.currently_available_offset - 1.second)
      end

      after do
        Timecop.return
      end

      it "should only find users with a markup time within the recent constraint" do
        result = UserModel.currently_available
        result.should include(@available_by_1_sec)
        result.should include(@available_exactly)
        result.should_not include(@not_available_by_1_sec)
      end

      it "should sort the available users by last_available_time descending" do
        result = UserModel.currently_available
        result.length.should == 2
        result[0].should == @available_by_1_sec
        result[1].should == @available_exactly
      end
    end
  end
end
