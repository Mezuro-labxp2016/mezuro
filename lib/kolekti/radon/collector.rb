module Kolekti
  module Radon
    class Collector < Kolekti::Collector
      def self.available?
        system('radon', '--version', [:out, :err] => '/dev/null') ? true : false
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path('../metrics.yml', __FILE__), 'Radon', [:PYTHON])

        super('Radon', 'Set of Python metric tools', supported_metrics)
      end

      def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        parsers_metric_configurations = Hash.new { |hash, key| hash[key] = [] }

        wanted_metric_configurations.each do |code, metric_configuration|
          parser = Kolekti::Radon::Parser::PARSERS[code]
          raise Kolekti::UnavailableMetricError.new("Metric does not belong to Radon") if parser.nil?

          parsers_metric_configurations[parser] << metric_configuration
        end

        parsers_metric_configurations.each do |parser_class, metric_configurations|
          parser = parser_class.new(metric_configurations, persistence_strategy)
          run_radon(code_directory, parser)
        end
      end

      def clean(code_directory, wanted_metric_configurations)
        super
      end
    end
  end
end
