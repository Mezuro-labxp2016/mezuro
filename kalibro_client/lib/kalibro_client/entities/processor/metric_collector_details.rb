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

module KalibroClient
  module Entities
    module Processor
      class MetricCollectorDetails < KalibroClient::Entities::Processor::Base
        attr_accessor :name, :description, :supported_metrics

        def supported_metrics=(value)
          @supported_metrics = {}
          value.each do |code, metric|
            if metric['type'] == 'HotspotMetricSnapshot'
              @supported_metrics[code] = KalibroClient::Entities::Miscellaneous::HotspotMetric.new(metric["name"], metric["code"], metric["languages"], metric["metric_collector_name"])
            else
              @supported_metrics[code] = KalibroClient::Entities::Miscellaneous::NativeMetric.new(metric["name"], metric["code"], metric["scope"], metric["languages"], metric["metric_collector_name"])
            end
          end
        end

        def find_metric_by_name(name)
          metric = self.supported_metrics.find {|code, metric| metric.name == name}
          metric.nil? ? nil : metric.last
        end

        def find_metric_by_name!(name)
          metric = self.find_metric_by_name(name)
          raise Likeno::Errors::RecordNotFound if metric.nil?
          metric
        end

        def find_metric_by_code(metric_code)
          @supported_metrics[metric_code]
        end

        def find_metric_by_code!(metric_code)
          metric = self.find_metric_by_code(metric_code)
          raise Likeno::Errors::RecordNotFound if metric.nil?
          metric
        end

        def self.find_by_name(metric_collector_name)
          begin
            self.find_by_name!(metric_collector_name)
          rescue Likeno::Errors::RecordNotFound
            nil
          end
        end

        def self.find_by_name!(metric_collector_name)
          new request(:find, {name: metric_collector_name})["metric_collector_details"]
        end

        def self.all_names
          request(:names, {}, :get)['metric_collector_names'].to_a
        end
      end
    end
  end
end
