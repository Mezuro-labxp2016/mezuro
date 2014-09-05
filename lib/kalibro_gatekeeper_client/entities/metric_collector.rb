# This file is part of KalibroGatekeeperClient
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

require "kalibro_gatekeeper_client/entities/model"

module KalibroGatekeeperClient
  module Entities
    class MetricCollector < Model
      attr_accessor :name, :description, :collector_class_name, :supported_metric, :wanted_metrics, :processing

      def supported_metric=(value)
        @supported_metric = KalibroGatekeeperClient::Entities::Metric.to_objects_array value
      end

      def supported_metrics
        @supported_metric
      end

      def metric(name)
        supported_metrics.find {|metric| metric.name == name}
      end

      def self.find_by_name(metric_collector_name)
        begin
          new request(:get, {name: metric_collector_name})
        rescue
          raise KalibroGatekeeperClient::Errors::RecordNotFound
        end
      end

      def self.all_names
        # FIXME: for some reason, the JSON is not getting automatically parsed
        JSON.parse(request(:all_names, {}, :get))['metric_collector_names'].to_a
      end

      def self.all
        metric_collectors = all_names
        metric_collectors.map{ |name| find_by_name(name) }
      end
    end
  end
end