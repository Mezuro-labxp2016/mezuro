require 'yaml'
require 'kalibro_client'

module Kolekti
  class Collector
    attr_reader :name, :description, :supported_metrics

    def self.run_if_available(command)
      begin
        `#{command}`
      rescue SystemCallError
        nil
      end
    end

    def self.available?; raise NotImplementedError; end

    def initialize(name, description, supported_metrics)
      @name = name
      @description = description
      @supported_metrics = supported_metrics
    end

    def collect_metrics(code_directory, wanted_metric_configurations, persistence_strategy); raise NotImplementedError; end

    def clean(code_directory, wanted_metric_configurations); raise NotImplementedError; end

    def default_value_from(metric_configuration); raise NotImplementedError; end

    protected

    def parse_supported_metrics(metrics_path, metric_collector_name, languages)
      supported_metrics = {}
      YAML.load_file(metrics_path)[:metrics].each do | code, metric |
        if metric[:type] == "NativeMetricSnapshot"
          supported_metrics[code] = KalibroClient::Entities::Miscellaneous::NativeMetric.new(metric[:name], code, metric[:scope], languages, metric_collector_name)
        else
          supported_metrics[code] = KalibroClient::Entities::Miscellaneous::HotspotMetric.new(metric[:name], code, languages, metric_collector_name)
        end
      end
      supported_metrics
    end
  end
end
