module KalibroClient
  module Entities
    module Miscellaneous
      class CompoundMetric < Metric
        attr_accessor :script
        def initialize(name, code, scope, script)
          super('CompoundMetricSnapshot', name, code, scope)
          @script = script
        end

        def self.to_object(value)
          if value.is_a?(Hash)
            new(value['name'], value['code'], value['scope'], value['script'])
          else
            value
          end
        end
      end
    end
  end
end
