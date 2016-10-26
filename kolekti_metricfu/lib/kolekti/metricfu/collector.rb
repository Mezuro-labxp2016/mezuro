require 'tempfile'

module Kolekti
  module Metricfu
    class Collector < Kolekti::Collector
      def self.available?
        # FIXME: below is the better form of writing this, but it does not look compatible with ruby 2.1.5 and 2.0.0
        # system('metric_fu --version', [:out, :err] => '/dev/null') ? true : false
        system('metric_fu --version', out: '/dev/null', err: '/dev/null') ? true : false
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path('../metrics.yml', __FILE__),
          'MetricFu',
          [:RUBY]
        )

        super('MetricFu', 'Set of Ruby metric tools', supported_metrics)
      end

      def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        tmp_file = Tempfile.new(['metric_fu', '.yml'], code_directory)
        begin
          Dir.chdir(code_directory) do
            unless system('metric_fu', '--format', 'yaml', '--out', tmp_file.path, '--no-reek', out: '/dev/null', err: '/dev/null')
              raise Kolekti::CollectorError.new('MetricFu failed')
            end
          end
          Kolekti::Metricfu::Parsers.parse_all(tmp_file.path, wanted_metric_configurations, persistence_strategy)
        ensure
          tmp_file.close!
        end
      end

      def clean(code_directory, wanted_metric_configurations)
        # Does not need to do anything, as collect metrics cleans things up already through a rescue block
      end

      def default_value_from(metric_configuration)
        metric = metric_configuration.metric
        if metric.type != 'NativeMetricSnapshot'
          raise Kolekti::UnavailableMetricError.new('Invalid Metric configuration type')
        end

        parser = nil
        if metric.metric_collector_name == self.name
          parser = Kolekti::Metricfu::Parsers::PARSERS[metric.code.to_sym]
        end

        raise Kolekti::UnavailableMetricError.new('Metric configuration does not belong to MetricFu') if parser.nil?

        parser.default_value
      end
    end
  end
end
