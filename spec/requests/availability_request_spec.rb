require 'spec_helper'

describe User::AvailabilitiesController do

  describe "#create" do
    let(:user) do
      u = Factory(:user)
      u.extend User::Availability
      u
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
      u = Factory(:available_user)
      u.extend User::Availability
      u
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
