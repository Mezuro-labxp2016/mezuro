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
      class KalibroModule < KalibroClient::Entities::Processor::Base
        attr_accessor :granularity, :id, :long_name, :module_result_id

        def initialize(attributes = {}, persisted = false)
          super
          @granularity = KalibroClient::Entities::Miscellaneous::Granularity.new attributes['granularity']['type']
        end

        def name=(value)
          @long_name = (value.is_a?(Array) ? value.join('.') : value)
        end

        def name
          @long_name.split('.')
        end

        def short_name
          name.last
        end
      end
    end
  end
end
