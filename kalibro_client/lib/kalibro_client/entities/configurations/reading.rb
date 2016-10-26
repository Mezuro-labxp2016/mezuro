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
      class Reading < KalibroClient::Entities::Configurations::Base

        attr_accessor :id, :label, :grade, :color, :reading_group_id

        def id=(value)
          @id = value.to_i
        end

        def reading_group_id=(value)
          @reading_group_id = value.to_i
        end

        def self.readings_of(reading_group_id)
          create_objects_array_from_hash(request('', {}, :get, "reading_groups/#{reading_group_id}"))
        end

        private

        def save_params
          {reading: self.to_hash, reading_group_id: reading_group_id}
        end

        def save_prefix
          "reading_groups/#{reading_group_id}"
        end

        def destroy_prefix
          "reading_groups/#{reading_group_id}"
        end

        def update_prefix
          "reading_groups/#{reading_group_id}"
        end
      end
    end
  end
end
