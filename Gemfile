source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'haml-rails'
gem 'jquery-rails'
gem 'pg'
gem 'unicorn'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem "therubyracer"
  gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
  gem "twitter-bootstrap-rails"
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

group :test do
  gem "capybara", ">= 1.0.0"
  gem "database_cleaner", "0.5.2"
  gem "faker", ">= 0.3.1" 
  gem "fakeweb", ">= 1.3.0" 
  gem "launchy", ">= 0.4.0"
  gem 'machinist', '>= 2.0.0.beta2'
end

group :test, :development do
  gem "rspec-rails", ">= 2.5"
  gem 'debugger'
end

group :development do
  gem "syntax"
end