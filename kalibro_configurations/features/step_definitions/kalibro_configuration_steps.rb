Given(/^I have a sample kalibro configuration$/) do
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration)
end

Given(/^the sample kalibro configuration has tree metric configurations$/) do
  @tree_metric_configuration_1 = FactoryGirl.create(:tree_metric_configuration,
    kalibro_configuration_id: @kalibro_configuration.id)
  @tree_metric_configuration_2 = FactoryGirl.create(:tree_metric_configuration,
    kalibro_configuration_id: @kalibro_configuration.id)
end

Given(/^the sample kalibro configuration has hotspot metric configurations$/) do
  @hotspot_metric_configuration_1 = FactoryGirl.create(:hotspot_metric_configuration,
    kalibro_configuration_id: @kalibro_configuration.id)
  @hotspot_metric_configuration_2 = FactoryGirl.create(:hotspot_metric_configuration,
    kalibro_configuration_id: @kalibro_configuration.id)
end

When(/^I ask for the metric configurations of the sample kalibro configuration$/) do
  @response = @kalibro_configuration.metric_configurations
end

When(/^I ask for the tree metric configurations of the sample kalibro configuration$/) do
  @response = @kalibro_configuration.tree_metric_configurations
end

When(/^I ask for the hotspot metric configurations of the sample kalibro configuration$/) do
  @response = @kalibro_configuration.hotspot_metric_configurations
end

Then(/^I should not get any metric configuration$/) do
  expect(@response).to be_empty
end

Then(/^I should get the tree metric configurations$/) do
  expect(@response).to include(@tree_metric_configuration_1, @tree_metric_configuration_2)
end

Then(/^I should get the hotspot metric configurations$/) do
  expect(@response).to include(@hotspot_metric_configuration_1, @hotspot_metric_configuration_2)
end

Then(/^I should get only the tree metric configurations$/) do
  expect(@response).to match_array([@tree_metric_configuration_1, @tree_metric_configuration_2])
end

Then(/^I should get only the hotspot metric configurations$/) do
  expect(@response).to match_array([@hotspot_metric_configuration_1, @hotspot_metric_configuration_2])
end
