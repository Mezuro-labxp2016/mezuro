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
      class Processing < KalibroClient::Entities::Processor::Base

        attr_accessor :id, :date, :state, :error, :root_module_result_id, :error_message, :repository_id
        attr_reader :process_times

        def id=(value)
          @id = value.to_i
        end

        def repository_id=(value)
          @repository_id = value.to_i
        end

        def date=(value)
          @date = value.is_a?(String) ? DateTime.parse(value) : value
        end

        def process_times
          unless @process_times.nil?
            return @process_times
          end
          @process_times = ProcessTime.create_objects_array_from_hash(self.class.request(":id/process_times", {id: id}, :get))
        end

        def root_module_result_id=(value)
          @root_module_result_id = value.to_i
        end
      end
    end
  end
end
