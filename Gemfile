source 'https://rubygems.org'

# PostgreSQL driver
gem 'pg'

# Sinatra driver
gem 'sinatra'
gem 'sinatra-contrib'

require 'dotenv'
Dotenv.load
gem 'nokogiri'
gem 'activesupport'
gem 'activerecord'
gem 'bcrypt-ruby'

gem 'rake'

gem 'httparty'
gem 'shotgun'

group :test do
  gem 'database_cleaner', '~> 1.4.1'
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'rspec'
  gem 'capybara'
end

group :test, :development do
  gem 'factory_girl'
  gem 'faker'
  gem 'awesome_print'
end
