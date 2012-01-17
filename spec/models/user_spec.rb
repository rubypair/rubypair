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

end
