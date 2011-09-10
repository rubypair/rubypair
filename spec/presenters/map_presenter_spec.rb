require 'spec_helper'
require 'user_presenter'

describe MapPresenter do
  let(:users) do
    user = stub(:user)
    user.stub(:latlong).and_return([55.5,-3.0])
    user.stub(:latlong?).and_return(true)
    [user]
   end
   subject { MapPresenter.new(users) }

  it "chooses the right size" do
    subject.url(60, 60).should =~ /size=60x60/
  end

  it "should include a marker for the user" do
    subject.url(60, 60).should =~ /55.5,-3.0/
  end

end
