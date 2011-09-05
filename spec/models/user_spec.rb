require 'test_helper'

describe User do
  let (:user) { Factory.build(:user) }

  describe "twitter handle" do
    it "strips a prefixed @-symbol" do
      user.twitter = "@Lenary"
      user.twitter.should == "Lenary"
    end

    it "copes with no prefixed @-symbol" do
      user.twitter = "Lenary"
      user.twitter.should == "Lenary"
    end
  end

  describe "#interest_histogram" do
    before do
      User.create(interests: "foo, bar, blech")
      User.create(interests: "foo, Blech, foobar")
    end

    it "should generate a Hash counting the hits per reference" do
      expected = {
        "foo" => 2,
        "blech" => 2,
        "bar" => 1,
        "foobar" => 1,
      }

      User.interest_histogram.should == expected
    end

    it "should generate a tag cloud containing the N most popular" do
      expecteds = [
        ["blech", 2],
        ["foo", 2],
        ["bar", 1]
      ]

      cloud = User.tag_cloud 3

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

      User.tag_cloud(3).should == expected
    end
  end
end
