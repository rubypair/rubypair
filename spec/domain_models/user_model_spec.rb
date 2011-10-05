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
end
