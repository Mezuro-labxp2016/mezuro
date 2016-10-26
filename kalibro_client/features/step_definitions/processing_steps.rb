require 'timeout'

Given(/^I wait up for a ready processing$/) do
  Timeout::timeout(300) do
    while !@repository.has_ready_processing
      sleep(2)
    end
  end
end

When(/^I call the has_processing for the given repository$/) do
  @response = @repository.has_processing
end

When(/^I call the has_ready_processing for the given repository$/) do
  @response = @repository.has_ready_processing
end

When(/^I call the has_processing_after for the given repository with yerterday's date$/) do
  @response = @repository.has_processing_after(DateTime.now - 1)
end

When(/^I call the has_processing_before for the given repository with tomorrows's date$/) do
  @response = @repository.has_processing_before(DateTime.now + 1)
end

When(/^I call the last_processing_state method for the given repository$/) do
  @response = @repository.last_processing_state
end

When(/^I call the last_ready_processing method for the given repository$/) do
  @response = @repository.last_ready_processing
end

When(/^I call the first_processing method for the given repository$/) do
  @response = @repository.first_processing
end

When(/^I call the last_processing method for the given repository$/) do
  @response = @repository.last_processing
end

When(/^I call the first_processing_after method for the given repository and yesterday's date$/) do
  @response = @repository.first_processing_after(DateTime.now - 1)
end

When(/^I call the last_processing_before method for the given repository and tomorrow's date$/) do
  @response = @repository.last_processing_before(DateTime.now + 1)
end

When(/^I call the processing method for the given repository$/) do
  @response = @repository.processing
end

When(/^I call the processing_with_date method for the given repository and tomorrow's date$/) do
  @response = @repository.processing_with_date(DateTime.now + 1)
end

When(/^I call the processing_with_date method for the given repository and yesterday's date$/) do
  @response = @repository.processing_with_date(DateTime.now - 1)
end

Given(/^I wait up to (\d+) seconds$/) do |seconds|
  sleep(seconds.to_i)
end

Then(/^I should get a Processing with state "(.*?)"$/) do |state|
  expect(@response.state).to eq(state)
end

Then(/^I should get nil$/) do
  expect(@response).to be_nil
end

Then(/^I should get "(.*?)"$/) do |state|
  expect(@response).to eq(state)
end

Then(/^I should get a valid state$/) do
  # REFACTOR ME: maybe the list of valid states should be retrieved from the Processor
  states = ["PREPARING", "DOWNLOADING", "COLLECTING",
            "CHECKING", "BUILDING", "AGGREGATING", "CALCULATING", "INTERPRETING"]
  expect(states).to include(@response)
end

Then(/^I should get false$/) do
  expect(@response).to be_falsey
end

Then(/^I should get true$/) do
  expect(@response).to be_truthy
end

Then(/^I should get a Processing$/) do
  expect(@response).to be_a(KalibroClient::Entities::Processor::Processing)
end

Then(/^this processing should have process times$/) do
  expect(@response.process_times.first).to be_a(KalibroClient::Entities::Processor::ProcessTime)
end
