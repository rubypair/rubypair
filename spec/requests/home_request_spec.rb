# encoding: utf-8

require 'spec_helper'

describe HomeController do
  it 'should display the most recent users' do
    users = 2.times.map{ |n| FactoryGirl.create(:user) }

    visit '/'

    users.each do |user|
      page.should have_content(user.name)
      page.should have_content(user.twitter)
      page.should have_content(user.github_login)
    end
  end

  describe '#search' do
    it 'should perform a search by name' do
      user1 = FactoryGirl.create(:user, :name => "John Smith")
      user2 = FactoryGirl.create(:user, :name => "Jane Doe")

      visit '/search?query=john'
      page.should have_content(user1.name)
      page.should_not have_content(user2.name)
    end

    it 'should perform a search by github_login' do
      user1 = FactoryGirl.create(:user, :github_login => "jsmith")
      user2 = FactoryGirl.create(:user, :github_login => "jdoe")

      visit '/search?query=jsmith'
      page.should have_content(user1.name)
      page.should_not have_content(user2.name)
    end

    it 'should perform a search by location' do
      user1 = FactoryGirl.create(:user, :location => "New York, NY")
      user2 = FactoryGirl.create(:user, :location => "Los Angeles, CA")

      visit '/search?query=york'
      page.should have_content(user1.name)
      page.should_not have_content(user2.name)
    end

    it 'should perform a search by interests' do
      user1 = FactoryGirl.create(:user, :interests => "ruby,rails")
      user2 = FactoryGirl.create(:user, :interests => "java,grails")

      visit '/search?query=ruby'
      page.should have_content(user1.name)
      page.should_not have_content(user2.name)
    end
  end
end
