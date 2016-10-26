source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'

# Use PostgreSQL as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use Rails Html Sanitizer for HTML sanitization
gem 'rails-html-sanitizer', '~> 1.0'

# Deployment
gem 'capistrano', '~>3.4.0', require: false
gem 'capistrano-rails'
gem 'capistrano-bundler'
gem 'capistrano-rvm', '~>0.1.0'

# Startup script generation (server process manager)
gem 'foreman', '~>0.78.0'

group :test do
  # Easier test writing
  gem 'shoulda-matchers', '~> 2.8.0'

  # Test coverage
  gem 'simplecov', require: false

  # Code climate test coverage
  gem 'codeclimate-test-reporter', group: :test, require: nil
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Test framework
  gem 'rspec-rails', '~> 3.3.2'

  # Mock framework
  gem 'mocha', '~> 1.1.0'

  # Fixtures made easy
  gem 'factory_girl_rails', '~> 4.5.0'

  # Static code analyzer. Restricting version to be able to parse the newest ruby version
  gem 'rubocop', '>= 0.36'
end

group :development, :test, :cucumber do
  # cleans the database
  # Version fixed for >= 1.4.1, since 1.4.0 is broken. See:
  # https://github.com/DatabaseCleaner/database_cleaner/issues/317
  gem 'database_cleaner', '>= 1.4.1'
end

# Acceptance tests
group :cucumber do
  gem 'cucumber', '~> 1.3.16'
  gem 'cucumber-rails'
  gem 'poltergeist', '~> 1.6.0'
end

# Use Pumas as the app server
gem 'puma'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
