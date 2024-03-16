source 'https://rubygems.org'

gem 'rails', '~> 6.1.4.6'
ruby '3.1.0'

git 'https://github.com/rails/sprockets.git', ref: '4aa1c55e66463f982c05cc85b94375be52d0d3f9' do
  gem 'sprockets' # NOTE: temporarily use the master branch till a sprockets release is compatible with Ruby 3.1
end
gem 'sprockets-rails'

gem 'awesome_print'
gem "aws-sdk-s3", require: false
gem 'bootsnap', require: false
gem 'bootstrap', '~> 4.4.1'
gem 'carrierwave'
gem 'carrierwave_backgrounder', :github => 'lardawge/carrierwave_backgrounder'
gem 'cloudinary'
gem 'delayed_job_active_record'
gem 'daemons'
gem "friendly_id"
gem 'haml-rails'
gem 'jquery-rails'
gem 'listen'
gem 'mini_magick', ">= 4.9.4"
gem 'nokogiri'
gem 'pg'
gem 'puma', '~> 5.6.2'  # temporarily locked until configuration is correctly upgraded
gem 'stripe'
gem 'tinymce-rails', '~> 5.10.4'               # https://stackoverflow.com/questions/70305174/trestle-tinymce-gem-uncaught-typeerror-cannot-read-properties-of-undefined-rea
gem 'terser'
gem 'attr_encrypted'
gem 'blind_index'
gem 'net-imap', require: false     # Required by Ruby 3.1
gem 'net-pop', require: false     # Required by Ruby 3.1
gem 'net-smtp', require: false    # Required by Ruby 3.1

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
#  gem 'stripe-ruby-mock', '>= 3.0.1', :require => 'stripe_mock'
  gem 'stripe-ruby-mock', '~> 3.1.0.rc2', require: 'stripe_mock'
  gem "timecop"
end

group :test, :development do
  gem "rspec-rails"
  gem 'byebug'
end

group :development do
  gem "foreman"
  gem "syntax"
end
