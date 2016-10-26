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
      class RangeSnapshot < KalibroClient::Entities::Configurations::Base
        attr_accessor :label, :grade, :color, :comments
        attr_reader :beginning, :end
        include RangeMethods

        def grade=(value)
          @grade = value.to_f
        end
      end
    end
  end
end
