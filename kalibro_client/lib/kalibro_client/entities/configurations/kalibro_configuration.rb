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
    module Configurations
      class KalibroConfiguration < KalibroClient::Entities::Configurations::Base
        attr_accessor :id, :name, :description

        def id=(value)
          @id = value.to_i
        end

        def metric_configurations
          KalibroClient::Entities::Configurations::MetricConfiguration.create_objects_array_from_hash(self.class.request(':id/metric_configurations', {id: id}, :get))
        end

        def hotspot_metric_configurations
          hotspot_metric_configurations_hash = self.class.request(':id/hotspot_metric_configurations', {id: id}, :get)
          KalibroClient::Entities::Configurations::MetricConfiguration.create_objects_array_from_hash(
            {'metric_configurations' => hotspot_metric_configurations_hash['hotspot_metric_configurations']})
        end

        def tree_metric_configurations
          tree_metric_configurations_hash = self.class.request(':id/tree_metric_configurations', {id: id}, :get)
          KalibroClient::Entities::Configurations::MetricConfiguration.create_objects_array_from_hash(
            {'metric_configurations' => tree_metric_configurations_hash['tree_metric_configurations']})
        end
      end
    end
  end
end
