When(/^I call the metric results of method with the results root id of the given processing$/) do
  @response = KalibroClient::Entities::Processor::ModuleResult.find(@response.root_module_result_id).tree_metric_results
end

Given(/^I search a metric result with descendant values for the given metric result$/) do
  first_module_result = KalibroClient::Entities::Processor::ModuleResult.find(@response.root_module_result_id)

  metric_results = first_module_result.tree_metric_results
  @response = metric_results.first.descendant_values
end

When(/^I call the history of method with the metric name and the results root id of the given processing$/) do
  @response = KalibroClient::Entities::Processor::TreeMetricResult.history_of(@metric.name, @response.root_module_result_id, @repository.id)
end

When(/^I get the first metric result of the given processing$/) do
  @metric_result = KalibroClient::Entities::Processor::ModuleResult.find(@response.root_module_result_id)
                   .tree_metric_results.first
end

When(/^I ask for the module result of the given metric result$/) do
  @module_result = @metric_result.module_result
end

Then (/^I should get a Float list$/) do
  expect(@response).to be_a(Array)
  expect(@response.first).to be_a(Float)
end

Then(/^I should get a list of metric results$/) do
  expect(@response).to be_a(Array)
  expect(@response.first).to be_a(KalibroClient::Entities::Processor::MetricResult)
end

Then(/^I should get a list of date metric results$/) do
  expect(@response).to be_a(Array)
  expect(@response.first).to be_a(KalibroClient::Entities::Miscellaneous::DateMetricResult)
end

Then(/^the first metric result should have a metric configuration$/) do
  expect(@response.first.metric_configuration).to be_a(KalibroClient::Entities::Configurations::MetricConfiguration)
end

Then(/^I should get the metric result's module result$/) do
  expect(@module_result.id).to eq(@metric_result.module_result_id)
end

Then(/^the module result should have a granularity$/) do
  expect(@module_result.kalibro_module.granularity).to be_a(KalibroClient::Entities::Miscellaneous::Granularity)
end

