require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec)

# Copied from https://github.com/cucumber/cucumber-ruby/blob/master/Rakefile#L6
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
Dir['gem_tasks/**/*.rake'].each { |rake| load rake }

task default: [:spec, :cucumber, :rubocop]
