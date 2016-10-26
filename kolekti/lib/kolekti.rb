require 'kolekti/version'
require 'kolekti/collector'
require 'kolekti/runner'
require 'kolekti/persistence_strategy'
require 'kolekti/memory_persistence_strategy'
require 'kolekti/errors'
require 'kolekti/parser'

module Kolekti
  COLLECTORS = []

  def self.register_collector(collector)
    COLLECTORS << collector.new if collector.available? && !already_included?(collector)
  end

  def self.collectors
    COLLECTORS
  end

  def self.deregister_collector(collector)
    to_be_deregistered_index = COLLECTORS.find_index { |kollector| kollector.is_a?(collector) }
    raise ArgumentError.new("Collector #{collector} was not registered!") if to_be_deregistered_index.nil?
    COLLECTORS.delete_at(to_be_deregistered_index)
  end

  def self.default_metric_value(metric_configuration)
    metric = metric_configuration.metric

    collector = collectors.find { |coll| coll.name == metric.metric_collector_name }
    return nil if collector.nil?

    collector.default_value_from(metric_configuration)
  end

  private

  def self.already_included?(collector)
    COLLECTORS.any? { |kollector| kollector.is_a?(collector) }
  end
end
