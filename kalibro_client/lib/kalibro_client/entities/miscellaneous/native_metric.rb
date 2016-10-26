module KalibroClient
  module Entities
    module Miscellaneous
      class NativeMetric < Metric
        attr_accessor :languages, :metric_collector_name

        def initialize(name, code, scope, languages, metric_collector_name, type='NativeMetricSnapshot')
          super(type, name, code, scope)
          @languages = languages
          @metric_collector_name = metric_collector_name
        end

        def self.to_object(value)
          if value.is_a?(Hash)
            new(value['name'], value['code'], value['scope'], value['languages'], value['metric_collector_name'])
          else
            value
          end
        end
      end
    end
  end
end
