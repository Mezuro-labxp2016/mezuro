require 'json'
require 'kolekti'
require 'cc/analyzer/formatters/formatter'

module Kolekti
  module CcPhpMd
    class Parser < CC::Analyzer::Formatters::Formatter
      def initialize(collector, wanted_metric_configurations, persistence_strategy)
        @collector = collector
        @persistence_strategy = persistence_strategy
        @wanted_metric_configurations = metric_configurations_by_name(wanted_metric_configurations)
      end

      def write(data)
         begin
           jsdata = JSON.parse(data)
         rescue JSON::ParserError
           raise Kolekti::CollectorError.new("Failed parsing CodeClimate JSON data")
         end

         return true if jsdata["type"] != "issue"

         metric_configuration = @wanted_metric_configurations[jsdata["check_name"]]
         return true if metric_configuration.nil?

         location = jsdata["location"] || {}
         path = location["path"]
         lines = location["lines"] || {}
         line_number = lines["begin"]
         message = jsdata["description"]

         raise Kolekti::CollectorError.new("Unexpected CodeClimate JSON data") if !path || !line_number || !message

         @persistence_strategy.create_hotspot_metric_result(metric_configuration, module_name_for_path(path),
                                                            line_number, message)
         true
      end

      def failed(output)
        raise Kolekti::CollectorError.new("CodeClimate runner failed: #{output}")
      end

      private

      def metric_configurations_by_name(metric_configurations)
        result = {}
        metric_configurations.each_value do |metric_configuration|
          metric = metric_configuration.metric
          if metric.respond_to?(:metric_collector_name) && metric.metric_collector_name == @collector.name
            result[metric.name] = metric_configuration
          end
        end
        result
      end

      def module_name_for_path(file_path)
        without_extension = file_path.rpartition('.').first
        without_extension.gsub('.', '_').gsub('/', '.')
      end
    end
  end
end
