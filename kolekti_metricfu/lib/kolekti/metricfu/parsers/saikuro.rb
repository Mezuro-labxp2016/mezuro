module Kolekti
  module Metricfu
    module Parsers
      class Saikuro < Base
        def self.parse(collected_metrics_hash, metric_configuration, persistence_strategy)
          collected_metrics_hash[:files].each do |file|
            name_prefix = parse_file_name(file[:filename])
            file[:classes].each do |cls|
              # Filter duplicate methods, picking only the latest. Fortunately Hash::[] will pick the latest element
              # when receiveing an array.
              methods_by_name = cls[:methods].map { |method| [method[:name], method] }
              # FIXME: Since ruby 2.1 this can be replaced by 'methods_by_name.to_hash'
              methods = Hash[methods_by_name]
              methods.each_value do |method|
                value = method[:complexity]
                name_suffix = module_name_suffix(method[:name])
                module_name = name_prefix + name_suffix

                granularity = KalibroClient::Entities::Miscellaneous::Granularity::METHOD
                persistence_strategy.create_tree_metric_result(metric_configuration, module_name, value.to_f, granularity)
              end
            end
          end
        end

        def self.default_value
          1.0 # Just one branch
        end
      end
    end
  end
end
