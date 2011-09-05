require 'test_helper'

describe ProfilesHelper do
  describe "#monkey_slap_preferences" do
    it "makes 'Both' appear as 'Local or Remote'" do
      monkey_slap_preferences("Both").should == "Local or Remote"
    end

    it "leaves anything else alone" do
      ["Local", "Remote"].each do |preference|
        monkey_slap_preferences(preference).should == preference
      end
    end
  end
end
