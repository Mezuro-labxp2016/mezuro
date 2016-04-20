# SimpleCov for test coverage report
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/cucumber'
end

# The gem itself
require 'kolekti/radon'

require 'factory_girl'
FactoryGirl.find_definitions
