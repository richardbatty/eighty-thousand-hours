source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'devise'
# gem 'omniauth'

gem 'pg'

# for nice url slugs
gem 'friendly_id', '~> 4.0.0.beta14'

# authorisation
gem 'cancan'

# for uploading profile pictures
gem 'aws-s3'
gem 'paperclip', '~> 2.4'

# markdown
gem 'bluecloth'

# production-ready web server for heroku cedar stack
gem 'thin'

# emails us when the production app fails
gem 'exception_notification'

# sweet templating language
gem "haml-rails"

# AWESOME!!
gem 'rails-backbone'

# tranlations and localisations
gem 'rails-i18n'

gem 'activeadmin'

gem 'meta_search'

gem 'exception_notification'

group :development do
  gem 'ruby-debug19', :require => 'ruby-debug'
  # gem 'growl_notify'
  gem 'heroku' #included for rake db:mirror system calls
  gem 'pry'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'sass-rails',   '~> 3.1.4'

gem 'jquery-rails'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'rspec-rails'
  gem "capybara"
  # gem 'growl'
  # gem 'growl_notify'
  gem 'ruby_gntp'
  gem 'guard'
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem "guard-rspec"
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'guard-spork'
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
  gem 'jasmine'
end

group :test do
  gem "factory_girl_rails"
  gem 'launchy'
  # database_cleaner is necessary when database transactions are switched off,
  # in order to test js with selenium
  gem 'database_cleaner'
  gem 'spork', '~> 0.9.0.rc'
end
