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
      class Repository < KalibroClient::Entities::Processor::Base

        attr_accessor :id, :name, :description, :license, :period, :scm_type, :address, :kalibro_configuration_id, :project_id, :code_directory, :branch

        def self.repository_types
          request('types', {}, :get)['types'].to_a
        end

        def self.repositories_of(project_id)
          create_objects_array_from_hash(request('', {}, :get, "projects/#{project_id}"))
        end

        def id=(value)
          @id = value.to_i
        end

        def period=(value)
          @period = value.to_i
        end

        def kalibro_configuration_id=(value)
          @kalibro_configuration_id = value.to_i
        end

        def project_id=(value)
          @project_id = value.to_i
        end

        def process
          self.class.request("#{self.id}/process", {}, :get)
        end

        def cancel_processing_of_repository
          self.class.request(':id/cancel_process', {id: self.id}, :get)
        end

        def processing
          if has_ready_processing
            last_ready_processing
          else
            last_processing
          end
        end

        def processing_with_date(date)
          date = date.is_a?(String) ? DateTime.parse(date) : date
          if has_processing_after(date)
            first_processing_after(date)
          elsif has_processing_before(date)
            last_processing_before(date)
          else
            nil
          end
        end

        def has_processing
          self.class.request("#{self.id}/has_processing", {}, :get)['has_processing']
        end

        def has_ready_processing
          self.class.request("#{self.id}/has_ready_processing", {}, :get)['has_ready_processing']
        end

        def has_processing_after(date)
          self.class.request("#{self.id}/has_processing/after", {:date => date})['has_processing_in_time']
        end

        def has_processing_before(date)
          self.class.request("#{self.id}/has_processing/before", {:date => date})['has_processing_in_time']
        end

        def last_processing_state
          self.class.request("#{self.id}/last_processing_state", {}, :get)['processing_state']
        end

        def last_ready_processing
          Processing.new(self.class.request(':id/last_ready_processing', {id: self.id}, :get)['last_ready_processing'])
        end

        def first_processing
          Processing.new(self.class.request("#{self.id}/first_processing")['processing'])
        end

        def last_processing
          Processing.new(self.class.request("#{self.id}/last_processing")['processing'])
        end

        def first_processing_after(date)
          Processing.new(self.class.request("#{self.id}/first_processing/after", {:date => date})["processing"])
        end

        def last_processing_before(date)
          Processing.new(self.class.request("#{self.id}/last_processing/before", {:date => date})['processing'])
        end

        def self.branches(url, scm_type)
          request("/branches", {url: url, scm_type: scm_type})
        end

        private

        def save_params
          {repository: self.to_hash, project_id: project_id}
        end
      end
    end
  end
end
