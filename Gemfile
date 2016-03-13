source 'https://rubygems.org'


# Standard Rails packaging
gem 'rails', '4.2.5'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
gem 'active_model_serializers'


# Project-specific gems
gem 'devise', github: 'plataformatec/devise'
gem 'kaminari'
gem 'api-pagination'


group :development, :test do
  gem 'byebug'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end
