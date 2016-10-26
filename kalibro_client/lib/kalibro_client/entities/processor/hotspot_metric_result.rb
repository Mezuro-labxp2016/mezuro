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
      class HotspotMetricResult < KalibroClient::Entities::Processor::MetricResult

        attr_accessor :line_number, :message

        def initialize(attributes={}, persisted=false)
          @line_number = attributes["line_number"].to_i
          attributes.each do |field, value|
            if field != "line_number" and self.class.valid?(field)
              send("#{field}=", value)
            end
          end
          @persisted = persisted
        end

        def related_results
          HotspotMetricResult.create_objects_array_from_hash(self.class.request(":id/related_results",
                                                                                {id: self.id}, :get))
        end
      end
    end
  end
end
