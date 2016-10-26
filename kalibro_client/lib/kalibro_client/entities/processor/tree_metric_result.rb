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
      class TreeMetricResult < KalibroClient::Entities::Processor::MetricResult
        attr_accessor :aggregated_value

        def initialize(attributes={}, persisted=false)
          value = attributes["value"]
          @value = (value == "NaN") ? attributes["aggregated_value"].to_f : value.to_f
          attributes.each do |field, value|
            if field!= "value" and field!= "aggregated_value" and self.class.valid?(field)
              send("#{field}=", value)
            end
          end
          @kalibro_errors = []
          @persisted = persisted
        end

        def aggregated_value=(value)
          @aggregated_value = value.to_f
        end

        def descendant_values
          descendant_values = self.class.request(':id/descendant_values', {id: id}, :get)['descendant_values']
          descendant_values.map {|descendant_value| descendant_value.to_f}
        end

        def self.history_of(metric_name, kalibro_module_id, repository_id)
          response = Repository.request(':id/metric_result_history_of', {metric_name: metric_name,
                                                        kalibro_module_id: kalibro_module_id,
                                                        id: repository_id})['metric_result_history_of']
          response.map { |date_metric_result|
            KalibroClient::Entities::Miscellaneous::DateMetricResult.new date_metric_result }
        end
      end
    end
  end
end
