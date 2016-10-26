# Copied from https://github.com/cucumber/cucumber-ruby/blob/master/gem_tasks/cucumber.rake

require 'cucumber/rake/task'
require 'cucumber/platform'

Cucumber::Rake::Task.new(:features) do |t|
  t.fork = true
end

task cucumber: :features
