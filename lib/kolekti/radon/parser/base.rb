module Kolekti
  module Radon
    module Parser
      class Base < Kolekti::Parser
        attr_reader :metric_configurations, :persistence_strategy, :logger

        def initialize(metric_configurations, persistence_strategy, logger)
          @metric_configurations = metric_configurations
          @persistence_strategy = persistence_strategy
          @logger = logger
        end

        def command; raise NotImplementedError; end

        # Default implementation is somewhat naive, but works for both Raw and
        # Maintainability Index - it just expects keys named the same as the
        # code for each metric configuration.
        def parse(raw_output)
          raw_output.each do |file_name, result_hash|
            module_name = self.class.parse_file_name(file_name)

            @metric_configurations.each do |metric_configuration|
              value = result_hash[metric_configuration.metric.code] unless result_hash.key?('error')
              value ||= self.class.default_value

              @persistence_strategy.create_tree_metric_result(
                metric_configuration, module_name, value.to_f,
                KalibroClient::Entities::Miscellaneous::Granularity::PACKAGE)
            end
          end
        end
      end
    end
  end
end
