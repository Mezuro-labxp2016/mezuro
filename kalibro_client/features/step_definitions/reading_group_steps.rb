Given(/^I have a reading group with name "(.*?)"$/) do |name|
  @reading_group = FactoryGirl.create(:reading_group, {name: name})
end

When(/^I ask for all the reading groups$/) do
  @all_reading_groups = KalibroClient::Entities::Configurations::ReadingGroup.all
end

When(/^I call the reading_group_of method for the given MetricConfiguration$/) do
  @metric_configuration_reading_group = KalibroClient::Entities::Configurations::ReadingGroup.reading_group_of(@metric_configuration.id)
end

Then(/^I should get a list with the given reading group$/) do
  expect(@all_reading_groups).to include(@reading_group)
end

Then(/^I should get the given RedingGroup$/) do
  expect(@metric_configuration_reading_group).to eq(@reading_group)
end

When(/^I destroy the reading group$/) do
  @reading_group.destroy
end

Then(/^the reading group should no longer exist$/) do
  expect(KalibroClient::Entities::Configurations::ReadingGroup.exists?(@reading_group.id)).to be_falsey
end

When(/^I create a reading group with name "(.*?)"$/) do |name|
  @reading_group = FactoryGirl.create(:reading_group, {name: name})
end

Then(/^the reading group should exist$/) do
  expect(KalibroClient::Entities::Configurations::ReadingGroup.exists?(@reading_group.id)).to be_truthy
end

