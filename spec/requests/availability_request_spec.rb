require 'spec_helper'

describe AvailabilitiesController do

  describe "#create" do
    let(:user) { Factory(:user) }

    before do
      post availability_path(user)
    end

    it "should set a user as available" do
      user.should be_available
    end
  end

  describe "#destroy" do
    let (:user) { Factory(:available_user) }

    before do
      delete availability_path(user)
    end

    it "should set a user as unavailable" do
      user.should_not be_available
    end
  end
end
