ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "capybara/rspec"

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:default] = {
  'user_info' => {
    'name' => "Foo Bar",
    'email' => "foo@example.com",
    'urls' => {
      'GitHub' => "http://github.com/foobar",
      'Blog' => "http://foobar.tumblr.com",
    }    
  },
  'extra' => {
    'user_hash' => {
      'login' => "foobar",
      'gravatar_id' => "foobar",
      'location' => "Not in Portland, OR"
    }
  }
}

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.orm = "mongoid"
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  config.include AuthMacros
end