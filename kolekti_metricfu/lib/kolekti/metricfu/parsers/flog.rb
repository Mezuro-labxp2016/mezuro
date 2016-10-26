module Kolekti
  module Metricfu
    module Parsers
      class Flog < Base
        def self.parse(collected_metrics_hash, metric_configuration, persistence_strategy)
          collected_metrics_hash[:method_containers].each do |method_container|
            next if method_container[:path].nil? || method_container[:path].empty?
            name_prefix = self.parse_file_name(method_container[:path])

            method_container[:methods].each do |name, result|
              value = result[:score]

              name_suffix = module_name_suffix(name)

              next if name_suffix.nil? || name_suffix.empty?
              module_name = name_prefix + name_suffix
              granularity = KalibroClient::Entities::Miscellaneous::Granularity::METHOD

              persistence_strategy.create_tree_metric_result(metric_configuration, module_name, value.to_f, granularity)
            end
          end
        end

        def self.default_value
          0.0 # No pain, no gain
        end
      end
    end
  end
end
