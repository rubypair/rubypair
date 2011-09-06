require 'test_helper'

describe CommentsController do
  it 'should display a notice if the user is not logged in' do
    user = Factory(:user)
    
    visit '/signout'
    visit user_path(user)
    page.should have_content('Log in with GitHub to post comments')
  end
  
  it 'should display a notice if no comments are on a page' do
    user1 = Factory(:user)
    user2 = Factory(:user)
    
    login user1
    
    visit user_path(user2)
    page.should have_content('No comments')
  end
  
  it 'should be possible to comment on another user\'s page' do
    user1 = Factory(:user)
    user2 = Factory(:user)
    
    login user1
    
    visit user_path(user2)

    comment = 'This is a comment.'
    fill_in 'comment_body', :with => comment
    click_button 'Create Comment'
    
    page.should have_content(comment)
    page.should have_content(user1.name)
  end
  
  context 'when a user is on its own page' do
    it 'should be able to delete a comment' do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      comment = 'This is a comment.'
      user1.comments.create :body => comment, :author => user2.id
      
      login user1
      visit user_path(user1)
      
      click_link 'delete'
      page.should_not have_content(comment)
    end
    
    it 'should not be able to comment on his own page' do
      user1 = Factory(:user)
      login user1
      
      visit user_path(user1)
      page.should_not have_content('Create Comment')
    end
  end
end