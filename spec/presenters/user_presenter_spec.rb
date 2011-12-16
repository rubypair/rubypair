$LOAD_PATH << "."

require 'app/presenters/user_presenter'
require 'timecop'

describe UserPresenter do
  let(:user) { stub(:user) }

  describe "#pairing_preference" do
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

  describe "#available_now?" do
    before do
      Timecop.freeze(Time.now)
    end

    after do
      Timecop.return
    end

    subject { UserPresenter.new(user, nil).available_now? }

    it "is available when the last available time is <= 2 hours ago" do
      two_hours_ago = Time.now - (2 * 60 * 60)
      user.stub(:last_available_time).and_return(two_hours_ago)
      subject.should be_true
    end

    it "is not available when the last available time is > 2 hours ago" do
      two_hours_one_minute_ago = Time.now - (2 * 60 * 60) - 60
      user.stub(:last_available_time).and_return(two_hours_one_minute_ago)
      subject.should be_false
    end

    it "is not available when the last available time is nil" do
      user.stub(:last_available_time).and_return(nil)
      subject.should be_false
    end
  end
end
