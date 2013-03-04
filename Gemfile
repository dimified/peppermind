source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.12'
gem 'mongoid', '~> 3.1.0'
gem 'jquery-rails'
gem 'devise', '~> 2.2.3'
gem 'omniauth', '~> 1.1.3'
gem 'omniauth-browserid', '~> 0.0.1'
gem 'omniauth-facebook', '~> 1.4.1'
gem 'omniauth-openid', '~> 1.0.1'
gem 'omniauth-twitter', '~> 0.0.14'
gem 'simple_form', '~> 2.0.4'
gem 'sass-rails',   '~> 3.2.3'
gem 'compass', '~> 0.12.2'
gem 'compass-rails', '~> 1.0.3'
gem 'susy', '~> 1.0.5'
gem 'haml', '~> 4.0.0'
gem 'font-awesome-sass-rails', '~> 3.0.2.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Gems used in development environment
group :development do
	gem 'better_errors', '~> 0.6.0'
end

# Gems for production with deployment on Heroku
group :production do
  gem 'thin'
  gem 'pg'
end

group :test, :development do
	gem "rspec-rails",'~> 2.12.2'
  gem "factory_girl_rails", "~> 4.2.1"
  gem "capybara", "~> 2.0.2"
  gem "guard-rspec", "~> 2.5.0"
  gem "database_cleaner", "~> 0.9.1"
  gem "mongoid-rspec", "~> 1.7.0"
end