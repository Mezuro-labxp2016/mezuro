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

require 'kalibro_client/kalibro_cucumber_helpers/cleaner'

module KalibroClient
  module KalibroCucumberHelpers
    def self.clean_processor
      @processor_cleaner ||= KalibroClient::KalibroCucumberHelpers::Cleaner.new(:processor_address)
      @processor_cleaner.clean_database
    end

    def self.clean_configurations
      @configurations_cleaner ||= KalibroClient::KalibroCucumberHelpers::Cleaner.new(:configurations_address)
      @configurations_cleaner.clean_database
    end
  end
end
