When(/^I request the first hotspot metric result from the root module result$/) do
  root_module_result = KalibroClient::Entities::Processor::ModuleResult.find @repository.last_ready_processing.root_module_result_id
  @hotspot_metric_result = root_module_result.hotspot_metric_results.first
end

When(/^I ask for the related results for the given metric result$/) do
  @related_results = @hotspot_metric_result.related_results
end

Then(/^I should get a list of hotspot metric results including the given one$/) do
  expect(@related_results).to include(@hotspot_metric_result)
  @related_results.each do |related_result|
    expect(related_result).to be_a KalibroClient::Entities::Processor::HotspotMetricResult
  end
end
