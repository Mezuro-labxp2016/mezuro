require 'kolekti/cc_phpmd/parser'
require 'kolekti/collector'
require 'cc/cli'
require 'cc/analyzer'
require 'fileutils'

module Kolekti
  module CcPhpMd
    class Collector < Kolekti::Collector
      def self.create_cc_dir
        old_umask = File.umask
        begin
          File.umask(022)
          FileUtils.mkdir_p('/tmp/cc', mode: 0755)
        ensure
          File.umask(old_umask)
        end
      end

      def self.available?
        # Make sure the CodeClimate temporary directory is created world-readable,
        # otherwise it may be possible for the container not to be able to properly
        # access it.

        # It has to be done before any CC invocation or Docker will create the directory
        # owned by root (that behavior is fortunately deprecated starting with Docker 1.9)
        create_cc_dir

        system('codeclimate version', [:out, :err] => '/dev/null') ? true : false
      end

      def initialize
        supported_metrics = parse_supported_metrics(
          File.expand_path("../metrics.yml", __FILE__),
          'CodeClimate PHPMD', [:PHP])
        super('CodeClimate PHPMD', 'PHP Mess Detector', supported_metrics)

        self.class.create_cc_dir
      end

      def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy)
        FileUtils.chmod_R "a+rX", code_directory
        engine_registry = CC::Analyzer::EngineRegistry.new
        parser = Kolekti::CcPhpMd::Parser.new(self, wanted_metric_configurations, persistence_strategy)

        Dir.chdir(code_directory) do
          runner = CC::Analyzer::EnginesRunner.new(engine_registry, parser, code_directory, @@config, [])
          runner.run
        end
      end

      def clean(code_directory, wanted_metric_configurations); end

      private

      def self.config
        config = CC::Yaml::Nodes::Root.new
        config["engines"] = CC::Yaml::Nodes::EngineList.new(config).with_value({})
        config.engines["phpmd"] = CC::Yaml::Nodes::Engine.new(config.engines).with_value("enabled" => true)
        config
      end
      @@config = self.config
    end
  end
end
