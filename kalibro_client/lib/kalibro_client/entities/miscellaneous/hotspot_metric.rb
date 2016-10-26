module KalibroClient
  module Entities
    module Miscellaneous
      class HotspotMetric < NativeMetric
        def initialize(name, code, languages, metric_collector_name)
          super(name, code, KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE), languages, metric_collector_name, 'HotspotMetricSnapshot')
        end

        def self.to_object(value)
          if value.is_a?(Hash)
            new(value['name'], value['code'], value['languages'], value['metric_collector_name'])
          else
            value
          end
        end
      end
    end
  end
end
