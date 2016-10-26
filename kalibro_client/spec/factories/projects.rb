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
  factory :project, class: KalibroClient::Entities::Processor::Project do
    name "QtCalculator"
    description "A simple calculator for us."

    trait :with_id do
      id 1
    end

    factory :project_with_id, traits: [:with_id]
  end

  factory :another_project, class: KalibroClient::Entities::Processor::Project do
    id 42
    name "Kalibro"
    description "A Kalibro description."
  end

end
