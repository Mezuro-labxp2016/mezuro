require 'kolekti/collector'

require 'cc/cli'
require 'cc/analyzer'

module Kolekti
  module CcPhpMd
    class Collector < Kolekti::Collector
      def self.available?
        system('codeclimate version', [:out, :err] => '/dev/null') ? true : false
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path("../metrics.yml", __FILE__), 'CodeClimate PHPMD', [:PHP])
        super('CodeClimate PHPMD', 'PHP Mess Detector', supported_metrics)
      end

      def collect_metrics(code_directory, wanted_metric_configurations)
        engine_registry = CC::Analyzer::EngineRegistry.new
        filesystem = CC::Analyzer::Filesystem.new('.')
        formatter = CC::Analyzer::Formatters::JSONFormatter.new(filesystem)
        config = CC::Yaml::Nodes::Root.new
        config["engines"] = CC::Yaml::Nodes::EngineList.new(config).with_value({})
        config.engines["phpmd"] = CC::Yaml::Nodes::Engine.new(config.engines).with_value("enabled" => true)

        Dir.chdir(code_directory) do
          runner = CC::Analyzer::EnginesRunner.new(engine_registry, formatter, code_directory, config, [])
          runner.run
        end
      end
    end
  end
end
