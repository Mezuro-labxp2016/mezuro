require 'kolekti/radon/parser'

module Kolekti
  module Radon
    class Collector < Kolekti::Collector
      def self.available?
        system('radon', '--version', [:out, :err] => '/dev/null') ? true : false
      end

      def self.logger
        if @logger.nil?
          @logger = Logger.new(STDERR)
          @logger.progname = 'kolekti/radon'
        end

        @logger
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path('../metrics.yml', __FILE__), 'Radon', [:PYTHON])

        super('Radon', 'Set of Python metric tools', supported_metrics)
      end

      def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        parsers_metric_configurations = Hash.new { |hash, key| hash[key] = [] }

        wanted_metric_configurations.each do |_, metric_configuration|
          parser = metric_configuration_parser(metric_configuration)
          parsers_metric_configurations[parser] << metric_configuration
        end

        parsers_metric_configurations.each do |parser_class, metric_configurations|
          parser = parser_class.new(metric_configurations, persistence_strategy, self.class.logger)
          run_radon(code_directory, parser)
        end
      end

      def clean(code_directory, wanted_metric_configurations)
        super
      end


      def default_value_from(metric_configuration)
        metric_configuration_parser(metric_configuration).default_value
      end

      private

      def run_radon(code_directory, parser)
        io = IO.popen(['radon', parser.command, '.', '--json'], chdir: code_directory)

        begin
          results = JSON.load(io)
        rescue JSON::JSONError, IOError
          raise Kolekti::CollectorError.new('Error while parsing Radon output')
        ensure
          io.close
          status = last_process_exitstatus
        end

        raise Kolekti::CollectorError.new("Radon failed") if status != 0

        parser.parse(results)
      end

      # Work around the lack of any sane way to mock $? in tests by splitting it up into a separate method
      #:nocov:
      def last_process_exitstatus
        $?.exitstatus
      end
      #:nocov:

      def metric_configuration_parser(metric_configuration)
        metric = metric_configuration.metric
        if metric.type != 'NativeMetricSnapshot'
          raise Kolekti::UnavailableMetricError.new('Invalid Metric configuration type')
        end

        parser = nil
        if metric.metric_collector_name == self.name
          parser = Kolekti::Radon::Parser::PARSERS[metric.code.to_sym]
        end

        if parser.nil?
          raise Kolekti::UnavailableMetricError.new('Metric configuration does not belong to Radon')
        end

        parser
      end
    end
  end
end
