require 'spec_helper'

describe CommentsController do
  
  context 'when a user is not logged in' do
    it 'should display a notice' do
      user = Factory(:user)

      visit '/signout'
      visit user_path(user)
      page.should_not have_content('My Profile')
      page.should have_content('Log in with GitHub to post comments')
    end
    
    it 'should forbid posting comments' do
      user1 = Factory(:user)
      
      comment = 'This is a comment.'

      post url_for([user1, user1.comments.build]), 'comment[body]' => comment
      get user_path(user1)
      
      response.body.should_not include(comment)
      response.body.should include('author comments')
    end
    
    it 'should forbid editing comments' do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      comment = 'This is a comment.'
      comment2 = 'This is a modified comment.'
      new_comment = user1.comments.create body: comment, author: user2.id
      
      put user_comment_path(user1, new_comment), 'comment[body]' => comment2
      get user_path(user1)
      
      response.body.should_not include(comment2)
      response.body.should include('author comments')
    end
    
    it 'should forbid deleting comments' do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      comment = 'This is a comment.'
      new_comment = user1.comments.create body: comment, author: user2.id
      delete user_comment_path(user1, new_comment)
      get user_path(user1)
      
      response.body.should include(comment)
      response.body.should include('author comments')
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
    fill_in 'comment_body', with: comment
    click_button 'Create Comment'
    
    page.should have_content(comment)
    page.should have_content("you")
  end
  
  it 'should be possible to edit or delete a previously created comment' do
    user1 = Factory(:user)
    user2 = Factory(:user)
    
    comment = 'This is a comment.'
    user1.comments.create body: comment, author: user2.id
    
    login user2
    visit user_path(user1)
    
    page.should have_content('you')
    page.should have_content('edit')
    page.should have_content('delete')
  end
  
  context 'when a user is on its own page' do
    it 'should be able to delete a comment' do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      comment = 'This is a comment.'
      user1.comments.create body: comment, author: user2.id
      
      login user1
      visit user_path(user1)
      
      click_link 'delete'
      page.should_not have_content(comment)
    end
    
    it 'should not be able to edit a comment' do
      user1 = Factory(:user)
      user2 = Factory(:user)
      
      login user1
      
      comment1 = 'This is a comment.'
      comment2 = 'This is a modified comment.'
      user_comment1 = user1.comments.create body: comment1, author: user2.id
      
      visit edit_user_comment_path(user_comment1.user, user_comment1)
      current_path.should == user_path(user1)
      
      page.should_not have_content(comment2)
      page.should have_content('author comments')
      
      put user_comment_path(user_comment1.user, user_comment1), 'comment[body]' => comment2
      get user_path(user1)
      
      response.body.should_not include(comment2)
      response.body.should include('author comments')
    end
    
    it 'should not be able to comment on his own page' do
      user1 = Factory(:user)
      login user1
      
      visit user_path(user1)
      page.should_not have_content('Create Comment')
    end
  end
end