source 'https://rubygems.org'

 gem 'rails', '3.2.1'
 gem 'activerecord', '3.2.1'
 gem 'activesupport', '3.2.1'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'sequel', '3.42.0'
gem 'json' , '1.6.6'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'libv8', '~> 3.11.8'
  gem 'therubyracer'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano' , :group => :development

# To use debugger
# gem 'ruby-debug'

group :test, :development do
	gem 'capybara'
	gem 'database_cleaner'
	gem 'email_spec'
end

group :test do
	gem 'cucumber-rails'#, '1.0.6'
	gem 'rspec-rails', '~> 2.5'
end

gem 'devise', '~> 1.4.3'
gem 'cancan'