require 'spec_helper'

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
end
