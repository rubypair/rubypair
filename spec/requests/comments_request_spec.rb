require 'spec_helper'

describe CommentsController do
  
  context 'when a user is not logged in' do
    it 'should display a notice' do
      user = Factory(:user)

      visit '/signout'
      visit user_path(user)
      page.should have_content('Log in with GitHub to post comments')
    end
    
    it 'should forbid posting comments', :last => true do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      comment = 'This is a comment.'
      post url_for([user1, Comment.new]), 'comment[body]' => comment
      get user_path(user1)
      
      response.body.should include('You are not able to post comments')
      response.body.should_not include(comment)
    end
    
    it 'should forbid deleting comments', :last => true do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      comment = 'This is a comment.'
      new_comment = user1.comments.create :body => comment, :author => user2.id
      delete user_comment_path(user1, new_comment)
      get user_path(user1)
      
      response.body.should include('You are not able to delete comments')
      response.body.should include(comment)
    end
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