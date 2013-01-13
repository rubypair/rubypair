require 'spec_helper'

describe SessionsController do
  it 'should log in and create an unknown user' do
    User.count.should be_zero

    user = FactoryGirl.build(:user, :github_login => 'jsmith')
    oauth_mock user

    visit '/auth/github'

    User.count.should == 1
    user = User.last

    current_path.should == edit_user_path(user)
    page.should have_css('.edit-user')
  end

  it 'should log in an existing user' do
    user = FactoryGirl.create(:user)
    oauth_mock user

    visit '/auth/github'
    current_path.should == '/'
  end

  it 'should log out a user' do
    user = FactoryGirl.create(:user)
    login user

    visit '/signout'
    current_path.should == '/'

    page.should have_css('#signin')
  end
end
