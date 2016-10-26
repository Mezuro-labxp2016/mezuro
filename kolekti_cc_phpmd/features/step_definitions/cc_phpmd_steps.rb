Given(/^PHPMD is registered on Kolekti$/) do
  Kolekti.register_collector(Kolekti::CcPhpMd::Collector)
end

Given(/^I have a set of wanted metrics for PHPMD$/) do
  @wanted_metric_configurations = Kolekti.collectors.first.supported_metrics.map { |_, metric|
    KalibroClient::Entities::Configurations::MetricConfiguration.new(metric: metric)
  }
end
