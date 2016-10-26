Given(/^I have a kalibro configuration with name "(.*?)"$/) do |name|
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration, {name: name})
end

When(/^I get all the kalibro configurations$/) do
  @all_kalibro_configurations = KalibroClient::Entities::Configurations::KalibroConfiguration.all
end

When(/^I create the kalibro configuration with name "(.*?)"$/) do |name|
  @kalibro_configuration = FactoryGirl.create(:kalibro_configuration, {name: name})
end

Then(/^I should get a list with the given kalibro configuration$/) do
  expect(@all_kalibro_configurations.include?(@kalibro_configuration)).to be_truthy
end

Then(/^the kalibro configuration should exist$/) do
  expect(KalibroClient::Entities::Configurations::KalibroConfiguration.exists?(@kalibro_configuration.id)).to be_truthy
end

When(/^I destroy the kalibro configuration$/) do
  @kalibro_configuration.destroy
end

Then(/^the kalibro configuration should no longer exist$/) do
  expect(KalibroClient::Entities::Configurations::KalibroConfiguration.exists?(@kalibro_configuration.id)).to be_falsey
end

Given(/^the kalibro configuration has a metric configuration$/) do
  @metric_configuration = FactoryGirl.create(:metric_configuration, kalibro_configuration_id: @kalibro_configuration.id)
end

When(/^I list all the metric configurations of the kalibro configuration$/) do
  @metric_configurations = @kalibro_configuration.metric_configurations
end

Then(/^I should get a list with the given metric configuration$/) do
  expect(@metric_configurations.include?(@metric_configuration)).to be_truthy
end

