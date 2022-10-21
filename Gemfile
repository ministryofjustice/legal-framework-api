# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 7.0.4"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.4"
# Use Puma as the app server
gem "puma", "~> 6.0"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false

gem "json-schema", "~> 3.0.0"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# Generate documentation
gem "rswag-api"
gem "rswag-ui"

group :development, :test do
  gem "awesome_print"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", ">= 6.2.0"
  gem "faker", ">=1.9.1"
  gem "json_expressions"
  gem "pry-byebug"
  gem "rspec_junit_formatter"
  gem "rspec-rails", "~> 6.0", ">= 6.0.1"
  gem "rswag-specs"
  gem "rubocop-govuk", require: false
  gem "rubocop-performance"
end

group :development do
  gem "guard-rubocop"
  gem "listen", "~> 3.7"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
end

group :test do
  gem "database_cleaner"
  gem "highline"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-rcov"
end

gem "net-imap"
gem "net-pop"
gem "net-smtp"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data"
