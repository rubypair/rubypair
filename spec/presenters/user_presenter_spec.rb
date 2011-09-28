$LOAD_PATH << "."

require 'app/presenters/user_presenter'

describe UserPresenter do
  describe "#pairing_preference" do
    let(:user) { stub(:user) }
    subject { UserPresenter.new(user, nil).pairing_preference }

    it "makes 'Both' appear as 'Local or Remote'" do
      user.stub(:remote_local_preference).and_return('Both')
      subject.should == "Local or Remote"
    end

    ["Local", "Remote"].each do |preference|
      it "returns #{preference} unchanged" do
        user.stub(:remote_local_preference).and_return(preference)
        subject.should == preference
      end
    end
  end
end
