require 'kolekti/persistence_strategy'

module Kolekti
  class MemoryPersistenceStrategy < Kolekti::PersistenceStrategy
    attr_reader :tree_metric_results, :hotspot_metric_results, :related_hotspot_metric_results

    def initialize
      @tree_metric_results = []
      @hotspot_metric_results = []
      @related_hotspot_metric_results = []
    end

    def create_tree_metric_result(metric_configuration, module_name, value, granularity)
      @tree_metric_results << {
        metric_configuration: metric_configuration,
        module_name: module_name,
        value: value,
        granularity: granularity
      }
    end

    def create_hotspot_metric_result(metric_configuration, module_name, line, message)
      result = {
        metric_configuration: metric_configuration,
        module_name: module_name,
        line: line,
        message: message
      }
      @hotspot_metric_results << result
      result
    end

    def create_related_hotspot_metric_results(metric_configuration, results)
      related_results = []

      results.each do |result|
        result = create_hotspot_metric_result(metric_configuration, result['module_name'], result['line'], result['message'])
        related_results << result
      end

      related_hotspot_metric_results << related_results
    end
  end
end
