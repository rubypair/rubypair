$LOAD_PATH << "."

require 'app/presenters/user_presenter'

describe UserPresenter do
  describe "#pairing_preference" do
    let(:user) {stub(:user)}
    subject { UserPresenter.new(user, nil).pairing_preference }

    it "makes only local appear as 'Local'" do
      user.stub(:local).and_return(true)
      user.stub(:remote).and_return(false)

      subject.should == "Local"
    end

    it "makes only remote appear as 'Remote'" do
      user.stub(:local).and_return(false)
      user.stub(:remote).and_return(true)

      subject.should == "Remote"
    end

    it "makes both local and remote appear as 'Local or Remote'" do
      user.stub(:local).and_return(true)
      user.stub(:remote).and_return(true)

      subject.should == "Local or Remote"
    end

    it "makes not local nor remote appear as 'Not Actively Pairing'" do
      user.stub(:local).and_return(false)
      user.stub(:remote).and_return(false)

      subject.should == "Not Actively Pairing. So sad..."
    end
  end
end
