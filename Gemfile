source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.13'
gem 'mongoid', '~> 3.1.4'
gem 'mongoid_auto_increment_id', '~> 0.6.1'
gem 'jquery-rails', '~> 2.2.2'
gem 'jquery-ui-rails', '~> 4.0.3'
gem 'devise', '~> 2.2.4'
gem 'omniauth', '~> 1.1.4'
gem 'omniauth-browserid', '~> 0.0.1'
gem 'omniauth-facebook', '~> 1.4.1'
gem 'omniauth-openid', '~> 1.0.1'
gem 'omniauth-twitter', '~> 0.0.16'
gem 'cancan', '~> 1.6.10'
gem 'simple_form', '~> 2.0.4'
gem 'haml-rails', '~> 0.4'
gem 'haml', '~> 4.0.3'
gem 'font-awesome-rails', '~> 3.1.1.2'
gem 'wicked', '~> 0.5.0'
gem 'kaminari', '~> 0.14.1'
gem 'mongoid_taggable', '~> 1.1.1'
gem 'dotiw', '~> 1.1.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# Gems used in development environment
group :development do
  gem 'better_errors', '~> 0.6.0'
  gem 'binding_of_caller'
  gem 'whenever', '~> 0.8.2', require: false
end

# Gems for production with deployment on Heroku
group :production do
  gem 'thin'
  gem 'pg', '~> 0.15.1'
end

group :test, :development do
  gem 'rspec-rails','~> 2.12.2'
  gem 'factory_girl_rails', '~> 4.2.1'
  gem 'guard-rspec', '~> 2.5.4'
end

group :test do
  gem 'capybara', '~> 2.0.3'
  gem 'database_cleaner', '~> 0.9.1'
  gem 'mongoid-rspec', '~> 1.7.0'
  gem 'faker', '~> 1.1.2'
  gem 'rb-fsevent', '~> 0.9'
end
