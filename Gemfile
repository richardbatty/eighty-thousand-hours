source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'devise'

gem 'pg'

# markdown
gem 'bluecloth'

# production-ready web server for heroku cedar stack
gem 'thin'

# emails us when the production app fails
gem 'exception_notification'

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'growl_notify'
  gem 'heroku' #included for rake db:mirror system calls
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.4'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rspec-rails'
  gem "capybara"
  gem "rb-fsevent"
  gem 'growl'
  gem "guard-rspec"
  gem 'guard-cucumber'
  gem 'guard-livereload'
  # gem 'guard-bundler'
  # gem 'guard-coffeescript'
  # gem 'guard-sass'
  # gem 'guard-uglify'
  # gem 'guard-jasmine-headless-webkit'
  # gem 'guard-rails-assets'
  # gem 'guard-sprockets'
  # gem 'guard-pow'
  # gem 'guard-jammit'
  gem "cucumber-rails"
end

group :test do
  gem "factory_girl_rails"
  gem 'launchy'
  # database_cleaner is necessary when database transactions are switched off,
  # in order to test js with selenium
  gem 'database_cleaner'
end
