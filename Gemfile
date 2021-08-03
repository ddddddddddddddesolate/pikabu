# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.1"

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.4"

gem "bootsnap", ">= 1.4.4", require: false

gem "activerecord-import"
gem "bcrypt"
gem "carrierwave"
gem "counter_culture"
gem "graphql"
gem "jwt"
gem "kaminari"
gem "rack-attack"
gem "search_object_graphql"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "graphiql-rails"
  gem "mailcatcher"
  gem "rspec-rails"
  gem "rubocop"
end

group :development do
  gem "listen", "~> 3.3"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
