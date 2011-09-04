source 'http://rubygems.org'

gem 'rails', '3.1.0'
# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mongoid'
gem 'mongoid_fulltext'
gem 'bson_ext'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'compass', :git => 'https://github.com/chriseppstein/compass.git', :branch => 'rails31'
  gem 'compass-960-plugin'
end

gem 'haml'
gem 'jquery-rails'
gem 'omniauth'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :development, :test do
  gem 'database_cleaner'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'minitest'
  gem 'mini_specunit'
  gem 'mini_backtrace'
  gem 'mini_shoulda'
  gem 'guard-minitest'
  gem 'rb-fsevent'
  gem 'libnotify'
  gem 'rb-inotify'
  #gem 'growl_notify'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
