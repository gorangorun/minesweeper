source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "stimulus-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem 'tailwindcss-rails', '~> 2.0', '>= 2.0.29'

group :development, :test do
  gem 'brakeman', '~> 5.4', '>= 5.4.1'
  gem 'bundler-audit', '~> 0.9.1'
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.1', '>= 3.1.1'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'rubocop', '~> 1.49', require: false
  gem 'rubocop-performance', '~> 1.16', require: false
  gem 'rubocop-rails', '~> 2.18', require: false
  gem 'rubocop-rspec', '~> 2.19', require: false
  gem 'shoulda-matchers', '~> 5.3'
end

group :development do

end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
