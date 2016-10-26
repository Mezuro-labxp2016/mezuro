# SimpleCov for test coverage report
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/cucumber'
end

require 'byebug'

# The gem itself
require 'kolekti/metricfu'

require 'factory_girl'
FactoryGirl.find_definitions
