source 'https://rubygems.org'

gem 'rails', '5.2.0'
ruby '2.4.2'

gem 'bootsnap', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'carrierwave'
gem 'carrierwave_backgrounder', :github => 'lardawge/carrierwave_backgrounder'
gem 'cloudinary'
gem 'delayed_job_active_record'
gem 'daemons'
gem "friendly_id"
gem 'haml-rails'
gem 'jquery-rails'
gem 'listen'
gem 'mini_magick'
gem 'nokogiri'
gem 'pg'
gem 'puma'                        # Heroku's recommended web server
gem 'stripe' # For taking membership payments
gem 'tinymce-rails'
gem 'tinymce-rails-imageupload'
gem "workless"
gem 'attr_encrypted'
gem 'blind_index'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'
group :production do
  gem 'newrelic_rpm'
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "faker"
  gem "fakeweb"
  gem "launchy"
  gem 'machinist', '>= 2.0.0.beta2'
  gem 'stripe-ruby-mock', '>= 2.5.0', :require => 'stripe_mock'
  gem "timecop"
end

group :test, :development do
  gem 'awesome_print'
  gem "rspec-rails"
  gem 'byebug'
end

group :development do
  gem "syntax"
end
