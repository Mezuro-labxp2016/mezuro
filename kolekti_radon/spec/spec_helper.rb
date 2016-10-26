require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/rspec'
end

require 'byebug'
require 'kalibro_client'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kolekti/radon'

require 'factory_girl'
FactoryGirl.find_definitions
