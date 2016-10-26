require_relative '../performance'

module Performance
  class MetricCollectorDetailsFindByCode < Base
    def subject
      KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name("Analizo").find_metric_by_code("acc")
    end
  end
end

Performance::MetricCollectorDetailsFindByCode.new.run