# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.0"

gem "bootsnap", ">= 1.4.4", require: false
gem "json-schema", "~> 4.1.1"
gem "net-imap"
gem "net-pop"
gem "net-smtp"
gem "pg", "~> 1.5"
gem "puma", "~> 6.4"
gem "rack-cors"
gem "rails", "~> 7.1.3"
gem "rswag-api"
gem "rswag-ui"
gem "sentry-rails"
gem "sentry-ruby"
gem "tzinfo-data"

group :development, :test do
  gem "awesome_print"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", ">= 6.2.0"
  gem "faker", ">=1.9.1"
  gem "json_expressions"
  gem "pry-byebug"
  gem "rspec_junit_formatter"
  gem "rspec-rails", "~> 6.1"
  gem "rswag-specs"
  gem "rubocop-govuk", require: false
  gem "rubocop-performance"
end

group :development do
  gem "guard-rubocop"
  gem "listen", "~> 3.8"
  gem "spring"
end

group :test do
  gem "database_cleaner"
  gem "highline"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov-rcov"
end
