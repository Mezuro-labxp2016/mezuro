require 'kolekti_metricfu/parsers/base'
require 'kolekti_metricfu/parsers/flog'
require 'kolekti_metricfu/parsers/saikuro'
require 'kolekti_metricfu/parsers/flay'

module KolektiMetricfu
  module Parsers
    @parsers = { 'flog' => Flog, 'saikuro' => Saikuro, 'flay' => Flay }

    def self.parse_all(results_yaml_path, wanted_metric_configurations, persistence_strategy)
      parsed_result = YAML.load_file(results_yaml_path)

      wanted_metric_configurations.each do |code, metric_configuration|
        @parsers[code].parse(parsed_result[code.to_sym], metric_configuration, persistence_strategy)
      end
    end
  end
end
