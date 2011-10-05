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
  
  context "#full_text_search" do
    before do
      @user1 = Factory(:user, :interests => "foo, bar, baz", :name => "Mandrelbot")
      @user2 = Factory(:user, :interests => "fu, bar, buzz")
    end
    
    it "should allow to search by term" do
      UserModel.fulltext_search("buzz").should == [@user2]
    end

    it "should not bring back results for 2 char queries" do
      UserModel.fulltext_search("fu").should == []
    end

    it "should search across searchable fiels (interests and name in this case)" do
      UserModel.fulltext_search("foo").should == [@user2, @user1]
    end

    it "should allow for maximum results" do
      UserModel.fulltext_search("foo", {:max_results => 1}).should == [@user2]
    end
    
  end
end
