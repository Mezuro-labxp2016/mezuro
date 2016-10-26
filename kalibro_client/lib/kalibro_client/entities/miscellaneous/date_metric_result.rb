module KalibroClient
  module Entities
    module Miscellaneous
      class DateMetricResult < KalibroClient::Entities::Miscellaneous::Base
        attr_reader :date, :metric_result

        def initialize(attributes={})
          @date = attributes["date"]
          @metric_result = KalibroClient::Entities::Processor::MetricResult.new attributes["metric_result"]
        end
      end
    end
  end
end
