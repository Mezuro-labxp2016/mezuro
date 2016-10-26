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

FactoryGirl.define do
  factory :repository, class: KalibroClient::Entities::Processor::Repository do
    name "QtCalculator"
    description "A simple calculator"
    license "GPLv3"
    period 1
    scm_type "SVN"
    address "svn://svn.code.sf.net/p/qt-calculator/code/trunk"
    kalibro_configuration_id 1
    project_id 1
    branch "master"
    code_directory nil

    trait :with_id do
      id 1
    end

    factory :repository_with_id, traits: [:with_id]
  end

  factory :another_repository, class: KalibroClient::Entities::Processor::Repository, parent: :repository do
    id 2
  end
end
