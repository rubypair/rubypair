require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context "#interest_histogram" do
    setup do
      User.create(interests: "foo, bar, blech")
      User.create(interests: "foo, Blech, foobar")
    end

    should "generate a Hash counting the hits per reference" do
      expected = {
        "foo" => 2,
        "blech" => 2,
        "bar" => 1,
        "foobar" => 1,
      }

      User.interest_histogram.must_equal expected
    end

    should "generate a tag cloud containing the N most popular" do
      expecteds = [
        ["blech", 2],
        ["foo", 2],
        ["bar", 1]
      ]

      cloud = User.tag_cloud 3

      expecteds.each do |expected|
        cloud.must_include expected
      end
    end

    should "return the tag cloud sorted by tag name" do
      expected = [
        ["bar", 1],
        ["blech", 2],
        ["foo", 2]
      ]

      User.tag_cloud(3).must_equal expected
    end
  end
end
