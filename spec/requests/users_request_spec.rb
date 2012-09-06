require 'spec_helper'

describe UsersController do
  describe '#show' do
    it 'should display a user profile' do
      user = FactoryGirl.create(:user)

      visit user_path(user)

      page.should have_content(user.name)
      page.should have_content(user.location)
      page.should have_content("E-mail")
      page.should have_content(user.twitter)
      page.should have_content(user.interests.split(",").join(", "))
    end
  end

  describe '#edit' do
    it 'should prevent a user to change another one\'s profile' do
      user1, user2 = *(2.times.map{ |n| FactoryGirl.create(:user) })
      login user1

      visit edit_user_path(user2)
      page.should have_content('Tsk tsk tsk!')
    end

    it 'should permit a user to update its profile' do
      user = FactoryGirl.create(:user)
      login user

      visit edit_user_path(user)
      page.should have_content("")

      fill_in 'user_twitter', :with => 'new_twitter'
      fill_in 'user_interests', :with => 'new,interests'
      select 'Local', :from => 'user_remote_local_preference'

      click_button 'Update User'

      user.reload
      user.remote_local_preference.should == "Local"
      user.twitter.should == 'new_twitter'
      user.interests.should == 'new,interests'
    end
  end
end
