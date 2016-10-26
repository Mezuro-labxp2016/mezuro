Given(/^the given reading group has the following readings:$/) do |table|
  hash = table.hashes.first
  hash[:reading_group_id] = @reading_group.id

  @reading = FactoryGirl.create(:reading, hash)
end

Given(/^I have a reading within the given reading group$/) do
  @reading = FactoryGirl.create(:reading, reading_group_id: @reading_group.id, grade: 10.5)
end

When(/^I ask for all the readings$/) do
  @all_readings = KalibroClient::Entities::Configurations::Reading.all
end

When(/^I ask for a reading with the same id of the given reading$/) do
  @found_reading = KalibroClient::Entities::Configurations::Reading.find @reading.id
end

When(/^I ask for the readings of the given reading group$/) do
  @found_readings = KalibroClient::Entities::Configurations::Reading.readings_of @reading_group.id
end

When(/^I ask to check if the given reading exists$/) do
  @response = KalibroClient::Entities::Configurations::Reading.exists?(@reading.id)
end

Then(/^I should get the given reading$/) do
  expect(@found_reading).to eq(@reading)
end

Then(/^I should get a list with the given reading$/) do
  expect(@found_readings.first).to eq(@reading)
end

Then(/^the response should contain the given reading$/) do
  expect(@all_readings.first).to eq(@reading)
end

When(/^I destroy the reading$/) do
  @reading.destroy
end

Then(/^the reading should no longer exist$/) do
  expect(KalibroClient::Entities::Configurations::Reading.exists?(@reading.id)).to be_falsey
end

