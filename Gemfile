source 'https://rubygems.org'

gem 'rails', '3.2.9'

gem 'sqlite3'
gem 'haml'
gem 'simple_form'
gem 'active_attr'

group :assets do
  gem 'libv8', '~> 3.11.8'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'compass_twitter_bootstrap'
  gem 'compass-rails'
end

gem 'jquery-rails'

# gem 'bcrypt-ruby', '~> 3.0.0'
# gem 'jbuilder'

group :development, :test do
  gem "rspec-rails", "~> 2.0"
  gem "launchy"
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  # gem 'capybara-webkit'
  gem 'guard-rspec'
  gem 'spork', '~> 1.0rc'
  gem 'guard-spork'
  gem 'rb-fsevent', :require => false
  gem 'rb-readline'
  gem 'valid_attribute', github: 'bcardarella/valid_attribute'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'simplecov', :require => false
end

group :development do
  gem "letter_opener"
end
