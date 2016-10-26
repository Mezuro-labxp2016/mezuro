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
  factory :metric_collector_details, class: KalibroClient::Entities::Processor::MetricCollectorDetails do
    name "Analizo"
    description "Analizo is a suite of source code analysis tools."
    supported_metrics { { "total_abstract_classes" => FactoryGirl.build(:metric).to_hash, "loc" => FactoryGirl.build(:loc).to_hash } }

    trait :another_metric_collector_details do
      name "Avalio"
      description "Avalio is another source code analyser that hasn't been developed yet."
    end

    factory  :another_metric_collector_details, traits: [:another_metric_collector_details]
  end
end
