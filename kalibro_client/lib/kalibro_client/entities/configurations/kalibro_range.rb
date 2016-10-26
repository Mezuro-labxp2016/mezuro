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

require 'kalibro_client/helpers/range_methods'

module KalibroClient
  module Entities
    module Configurations
      class KalibroRange < KalibroClient::Entities::Configurations::Base
        attr_accessor :id, :reading_id, :comments, :metric_configuration_id
        attr_reader :beginning, :end
        include RangeMethods

        def id=(value)
          @id = value.to_i
        end

        def metric_configuration_id=(value)
          @metric_configuration_id = value.to_i
        end

        def reading_id=(value)
          @reading_id = value.to_i
        end

        def label
          reading.label
        end

        def grade
          reading.grade
        end

        def color
          reading.color
        end

        def self.ranges_of(metric_configuration_id)
          self.create_objects_array_from_hash(request('', {}, :get, "metric_configurations/#{metric_configuration_id}"))
        end

        def reading
          @reading ||= KalibroClient::Entities::Configurations::Reading.find(reading_id)
          @reading
        end

        private

        def save_params
          {kalibro_range: self.to_hash, metric_configuration_id: self.metric_configuration_id}
        end

        def save_prefix
          "metric_configurations/#{metric_configuration_id}"
        end

        def update_prefix
          "metric_configurations/#{metric_configuration_id}"
        end

        def destroy_prefix
          "metric_configurations/#{metric_configuration_id}"
        end
      end
    end
  end
end
