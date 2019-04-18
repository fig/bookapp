source 'https://rubygems.org'
ruby '2.5.1'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", '5.2.1'
gem 'devise'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1.3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker', '>= 4.0.0.rc.3'
# Use SCSS for stylesheets
gem 'wdm', '>= 0.1.0'
# gem 'acts_as_votable', '~> 0.12.0'
gem 'bootstrap', '~> 4.3.1'
gem 'bootstrap_form'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails'
gem 'will_paginate', '~> 3.1.0'
gem 'rails_admin', '~> 1.3.0'
gem 'impressionist', git: 'https://github.com/jordanhudgens/impressionist'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'friendly_id', '~> 5.1.0'
gem 'selectize-rails'
source 'http://insecure.rails-assets.org/' do
  gem 'rails-assets-tether', '>= 1.1.0'
end
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'jquery-ui-rails'
gem "bootstrap_flash_messages", "~> 1.0.1"
# gem 'cancancan', '~> 2.0'
#rails-engine
gem 'notifications', '~> 0.6.0'
gem 'comments'
# gem 'merit'
# gem 'jquery-atwho-rails', '~> 1.5', '>= 1.5.4'
# gem 'redcarpet', '~> 3.3', '>= 3.3.4'
# gem 'sanitize', '~> 4.0', '>= 4.0.1'
# gem "mini_magick"
# gem 'emojionearea-rails', '~> 3.4.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'faker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
gem 'gon'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_bot'
  gem 'rails-controller-testing'
  gem 'headless'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner', '~> 1.6.1.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'annotate'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
