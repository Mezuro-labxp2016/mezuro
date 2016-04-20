require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/rspec'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kolekti/radon'
