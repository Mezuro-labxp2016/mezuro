# SimpleCov for test coverage report
require 'simplecov'
SimpleCov.start do
  add_group "Entities", "lib/kalibro_client/entities"
  add_group "Errors", "lib/kalibro_client/errors"
  add_group "Helpers", "lib/kalibro_client/helpers"
  add_group "Cucumber Helpers", "lib/kalibro_client/kalibro_cucumber_helpers"

  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/cucumber'
end

# Kalibro hooks
require 'kalibro_client/kalibro_cucumber_helpers/hooks'

# The gem itself
require 'kalibro_client'

require 'factory_girl'
FactoryGirl.find_definitions
