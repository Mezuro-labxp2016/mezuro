#!/usr/bin/env ruby

# This file is part of KalibroClient
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Inspired on: https://github.com/fog/fog/blob/master/lib/tasks/test_task.rb

require 'rake'
require 'rake/tasklib'

module KalibroClient
  module Rake
    class TestTask < ::Rake::TaskLib
      def initialize

        namespace :test do
          desc 'Runs acceptance and unit tests'
          task :all => [:units, :acceptance]

          desc 'Runs the unit tests'
          task :units do
            unit_tests_command = "bundle exec rspec spec"

            puts "Running the unit tests with \"#{unit_tests_command}\"\n\n"
            system unit_tests_command
          end

          desc 'Runs the acceptance tests'
          task :acceptance, [:feature] do |t, args|
            if args.feature.nil?
              acceptance_tests_command = "bundle exec cucumber"
            else
              acceptance_tests_command = "bundle exec cucumber #{args.feature} features/step_definitions/ features/support/"
            end

            puts "Running the acceptance tests with \"#{acceptance_tests_command}\"\n\n"
            system acceptance_tests_command
          end

          desc 'Runs the performance tests'
          task :performance do |t, args|
            performance_tests_command = "bundle exec ruby performance/tests/*"

            puts "Running the acceptance tests with \"#{performance_tests_command}\"\n\n"
            system performance_tests_command
          end
        end
      end
    end
  end
end

