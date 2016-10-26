module KalibroClient
  module Entities
    module Miscellaneous
      class Metric < KalibroClient::Entities::Miscellaneous::Base
        attr_accessor :type, :name, :code, :scope, :description

        def initialize(type, name, code, scope)
          @type = type
          @name = name
          @code = code
          self.scope = scope
          @description = ""
        end

        def scope=(value)
          if value.is_a?(Hash) && !value["type"].nil?
            value = value["type"]
          else
            value = value.to_s
          end
          @scope = KalibroClient::Entities::Miscellaneous::Granularity.new(value)
        end
      end
    end
  end
end
