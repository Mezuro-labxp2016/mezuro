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
  factory :date_metric_result, class: KalibroClient::Entities::Miscellaneous::DateMetricResult do
    date "2013-10-16T18:26:43.151+00:00"
    metric_result { FactoryGirl.build(:metric_result) }

    initialize_with { KalibroClient::Entities::Miscellaneous::DateMetricResult.new("date" => date, "metric_result" => metric_result.to_hash) }

    trait :another_date do
      date "2013-05-06T06:26:43.151+00:00"
    end

    factory :another_date_metric_result, traits: [:another_date]
  end
end
