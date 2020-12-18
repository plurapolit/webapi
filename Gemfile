# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'
gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'aws-sdk-transcribeservice'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'devise-jwt'
gem 'imgix-rails'
gem 'jbuilder', '~> 2.7'
gem 'paranoia'
gem 'pg'
gem 'puma', '~> 4.1'
gem 'rack-cors'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'sass-rails', '>= 6'
gem 'select2-rails'
gem 'sentry-raven'
gem 'sucker_punch'
gem 'turbolinks', '~> 5'
gem 'twitter-bootstrap-rails'
gem 'webpacker', '~> 4.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rails_best_practices'
  gem 'rubocop', require: false
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'bullet'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'seedbank'
  gem 'simplecov', require: false
  gem 'solargraph'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
