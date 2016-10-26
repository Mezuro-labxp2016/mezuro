Given(/^I have a set of wanted metrics for all the supported ones$/) do
  # TODO: this was copied from PHPMD. Adapt it to tree metrics as well
  @wanted_metric_configurations = Kolekti.collectors.first.supported_metrics.map do |_, metric|
    KalibroClient::Entities::Configurations::MetricConfiguration.new(metric: metric)
  end
end

Given(/^a persistence strategy is defined$/) do
  @persistence_strategy = FactoryGirl.build(:persistence_strategy)
end

When(/^I request Kolekti to collect the wanted metrics$/) do
  @runner = Kolekti::Runner.new(@repository_path, @wanted_metric_configurations, @persistence_strategy)
  @runner.run_wanted_metrics
end

Then(/^there should be metric results for all the wanted metrics$/) do
  metric_results = @persistence_strategy.tree_metric_results + @persistence_strategy.hotspot_metric_results
  metric_configurations = metric_results.map { |metric_result| metric_result[:metric_configuration] }.to_set

  @wanted_metric_configurations.each do |wanted_metric_configuration|
    expect(metric_configurations).to include(wanted_metric_configuration)
  end
end
