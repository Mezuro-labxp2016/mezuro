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
      class ModuleResult < KalibroClient::Entities::Processor::Base

        attr_accessor :id, :kalibro_module, :grade, :parent_id, :height, :processing_id

        def children
          response = self.class.request(':id/children', {id: id}, :get)
          self.class.create_objects_array_from_hash(response)
        end

        def parents
          if parent_id == 0
            []
          else
            parent = self.class.find(parent_id)
            parent.parents << parent
          end
        end

        def id=(value)
          @id = value.to_i
        end

        def kalibro_module
          @kalibro_module ||= KalibroClient::Entities::Processor::KalibroModule.to_object self.class.request(":id/kalibro_module", {id: id}, :get)["kalibro_module"]
        end

        def height=(value)
          @height = value.to_i
        end

        def processing_id=(value)
          @processing_id = value.to_i
        end

        def processing
          KalibroClient::Entities::Processor::Processing.find(self.processing_id)
        end

        def grade=(value)
          @grade = value.to_f
        end

        def parent_id=(value)
          @parent_id = value.to_i
        end

        def folder?
          self.children.count > 0
        end

        def file?
          !self.folder?
        end

        def self.history_of(module_result, repository_id)
          response = self.create_array_from_hash(Repository.request(':id/module_result_history_of', {id: repository_id, kalibro_module_id: module_result.kalibro_module.id})['date_module_results'])
          response.map do |date_module_result_pair|
            date_module_result = KalibroClient::Entities::Miscellaneous::DateModuleResult.new
            date_module_result.date = date_module_result_pair.first
            date_module_result.module_result = KalibroClient::Entities::Processor::ModuleResult.new date_module_result_pair.last
            date_module_result
          end
        end

        def tree_metric_results
          TreeMetricResult.create_objects_array_from_hash(self.class.request(":id/metric_results", {id: self.id}, :get))
        end

        def hotspot_metric_results
          HotspotMetricResult.create_objects_array_from_hash(self.class.request(":id/hotspot_metric_results",
                                                                                {id: self.id}, :get))
        end
      end
    end
  end
end
