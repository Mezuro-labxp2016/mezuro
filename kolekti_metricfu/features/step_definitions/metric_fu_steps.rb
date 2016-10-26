Given(/^MetricFu is registered on Kolekti$/) do
  Kolekti.register_collector(Kolekti::Metricfu::Collector)
end
