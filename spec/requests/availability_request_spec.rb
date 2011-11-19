require 'spec_helper'

describe AvailabilitiesController do

  describe "#create" do
    let(:user) do
      Factory(:user).tap do |u|
        u.extend Availability
      end
    end

    before do
      post user_availability_path(user)
    end

    it "should set a user as available" do
      user.reload.should be_available
    end

    it "should return a 201 created" do
      response.status.should == 201
    end
  end

  describe "#destroy" do
    let (:user) do
      Factory(:available_user).tap do |u|
        u.extend Availability
      end
    end

    before do
      delete user_availability_path(user)
    end

    it "should set a user as unavailable" do
      user.reload.should_not be_available
    end

    it "should return a 200 ok" do
      response.status.should == 200
    end
  end
end
