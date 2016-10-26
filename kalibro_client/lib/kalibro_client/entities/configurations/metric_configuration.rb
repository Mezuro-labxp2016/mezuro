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
      class MetricConfiguration < KalibroClient::Entities::Configurations::Base

        attr_accessor :id, :metric, :weight, :aggregation_form, :reading_group_id, :kalibro_configuration_id

        def id=(value)
          @id = value.to_i
        end

        def reading_group_id=(value)
          @reading_group_id = value.to_i
        end

        def kalibro_configuration_id=(value)
          @kalibro_configuration_id = value.to_i
        end

        def metric=(value)
          if value.is_a?(Hash)
            if value['type'] == "NativeMetricSnapshot"
              @metric = KalibroClient::Entities::Miscellaneous::NativeMetric.to_object(value)
            elsif value['type'] == "HotspotMetricSnapshot"
              @metric = KalibroClient::Entities::Miscellaneous::HotspotMetric.to_object(value)
            else
              @metric = KalibroClient::Entities::Miscellaneous::CompoundMetric.to_object(value)
            end
          elsif value.is_a?(KalibroClient::Entities::Miscellaneous::Metric)
            @metric = value
          else
            raise TypeError.new("Cannot cast #{value.inspect} into Metric")
          end

          return @metric
        end

        def weight=(value)
          @weight = value.to_f
        end

        def update_attributes(attributes={})
          attributes.each { |field, value| send("#{field}=", value) if self.class.valid?(field) }
          save
        end

        def to_hash
          super :except => [:configuration_id]
        end

        def self.metric_configurations_of(configuration_id)
          create_objects_array_from_hash(request('', {}, :get, "kalibro_configurations/#{configuration_id}"))
        end

        def kalibro_ranges
          KalibroClient::Entities::Configurations::KalibroRange.create_objects_array_from_hash(self.class.request(':id/kalibro_ranges', {id: id}, :get))
        end

        private

        def save_params
          {:metric_configuration => self.to_hash, :kalibro_configuration_id => self.kalibro_configuration_id}
        end
      end
    end
  end
end
