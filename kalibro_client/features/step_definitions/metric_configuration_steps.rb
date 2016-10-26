Given(/^I have a metric configuration within the given kalibro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             reading_group_id: @reading_group.id,
                                             kalibro_configuration_id: @kalibro_configuration.id)
end

Given(/^I have a metric configuration within the given kalibro configuration with the given metric$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             {metric: @metric,
                                              reading_group_id: @reading_group.id,
                                              kalibro_configuration_id: @kalibro_configuration.id})
end

Given(/^I have a "(.+)" configuration within the given kalibro configuration$/) do |metric_code|
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             metric: FactoryGirl.build(metric_code.to_sym),
                                             reading_group_id: @reading_group.id,
                                             kalibro_configuration_id: @kalibro_configuration.id)
end

Given(/^I have a hotspot metric configuration within the given kalibro configuration$/) do
  @hotspot_metric_configuration = FactoryGirl.create(:metric_configuration,
                                                     {metric: FactoryGirl.build(:hotspot_metric),
                                                      kalibro_configuration_id: @kalibro_configuration.id})
end

Given(/^I have a tree metric configuration within the given kalibro configuration$/) do
  step 'I have a "saikuro" configuration within the given kalibro configuration'
  @tree_metric_configuration = @metric_configuration
end

When(/^I search a metric configuration with the same id of the given metric configuration$/) do
  @found_metric_configuration = KalibroClient::Entities::Configurations::MetricConfiguration.find(@metric_configuration.id)
end

When(/^I search an inexistent metric configuration$/) do
  @is_error = false
  inexistent_id = rand(Time.now.to_i)
  begin
    KalibroClient::Entities::Configurations::MetricConfiguration.find(inexistent_id)
  rescue Likeno::Errors::RecordNotFound
    @is_error = true
  end
end

When(/^I request all metric configurations of the given kalibro configuration$/) do
  @metric_configurations = KalibroClient::Entities::Configurations::MetricConfiguration.metric_configurations_of(@kalibro_configuration.id)
end

When(/^I destroy the metric configuration$/) do
  @metric_configuration.destroy
end

When(/^I have a flay configuration within the given kalibro configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration,
                                             {metric: FactoryGirl.build(:hotspot_metric),
                                              weight: nil,
                                              aggregation_form: nil,
                                              reading_group_id: nil,
                                              kalibro_configuration_id: @kalibro_configuration.id})
end

When(/^I request for hotspot_metric_configurations of the given kalibro configuration$/) do
  @hotspot_metric_configurations = @kalibro_configuration.hotspot_metric_configurations
end

When(/^I request for tree_metric_configurations of the given kalibro configuration$/) do
  @tree_metric_configurations = @kalibro_configuration.tree_metric_configurations
end

Then(/^it should return the same metric configuration as the given one$/) do
  expect(@found_metric_configuration).to eq(@metric_configuration)
end

Then(/^I should get a list of its metric configurations$/) do
  expect(@metric_configurations).to eq([@metric_configuration])
end

Then(/^I should get an empty list of metric configurations$/) do
  expect(@metric_configurations).to eq([])
end

Then(/^the metric configuration should no longer exist$/) do
  expect { KalibroClient::Entities::Configurations::MetricConfiguration.find(@metric_configuration.id)}.to raise_error(Likeno::Errors::RecordNotFound)
end

Then(/^the metric configuration should exist$/) do
  @found_metric_configuration = KalibroClient::Entities::Configurations::MetricConfiguration.find(@metric_configuration.id)
  expect(@found_metric_configuration).to eq(@metric_configuration)
end

Then(/^its metric should be Hotspot one$/) do
  expect(@found_metric_configuration.metric).to be_a(KalibroClient::Entities::Miscellaneous::HotspotMetric)
end

Then(/^I should get a list with the given HotspotMetricConfiguration$/) do
  expect(@hotspot_metric_configurations).to include(@hotspot_metric_configuration)
end

Then(/^I should get a list with the given TreeMetricConfiguration$/) do
  expect(@tree_metric_configurations).to include(@tree_metric_configuration)
end
