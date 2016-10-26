require 'kolekti/errors'

# SPB runs on CentOS 7, which uses ruby 2.0.0-p598. On that version the Array class
# does not have the to_h method. The code below is a fix for that and should be removed
# when CentOS updates its ruby version. Version 2.1.0 already has Array#to_h built-in.
class Array
  def to_h
    result_hash = {}
    self.each do |code, metric_configuration|
      result_hash[code] = metric_configuration
    end
    return result_hash
  end
end

module Kolekti
  class Runner
    attr_reader :repository_path, :wanted_metric_configurations, :collectors

    def initialize(repository_path, wanted_metric_configurations, persistence_strategy)
      @repository_path = repository_path
      @wanted_metric_configurations = wanted_metric_configurations.map { |m| [m.metric.code, m] }.to_h
      @persistence_strategy = persistence_strategy
      @collectors = find_collectors
    end

    def run_wanted_metrics
      @collectors.each do |collector|
        collector.collect_metrics(@repository_path, @wanted_metric_configurations, @persistence_strategy)
      end
    end

    def clean_output
      @collectors.each do |collector|
        collector.clean(@repository_path, @wanted_metric_configurations)
      end
    end

    private

    def find_collectors
      collectors = wanted_metric_configurations.map do |code, metric_configuration|
        collector_name = metric_configuration.metric.metric_collector_name
        found_collector = Kolekti.collectors.find do |collector|
          collector.name == collector_name && collector.supported_metrics.include?(code.to_sym)
        end
        raise UnavailableMetricError.new("No Metric Collector for metric code #{code}") if found_collector.nil?

        found_collector
      end

      collectors.uniq
    end
  end
end
