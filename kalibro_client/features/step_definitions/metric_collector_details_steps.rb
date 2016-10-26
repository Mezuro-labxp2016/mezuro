When(/^I get all metric collector names$/) do
  @metric_collector_names = KalibroClient::Entities::Processor::MetricCollectorDetails.all_names
end

When(/^I search metric collector Analizo by name\!$/) do
  @response = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name!("Analizo")
end

When(/^I search metric collector Avalio by name\!$/) do
  @is_error = false
  begin
    KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name!("Avalio")
  rescue Likeno::Errors::RecordNotFound
    @is_error = true
  end
end

When(/^I search metric collector "(.+)" by name$/) do |name|
  @response = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(name)
end

Then(/^it should return Analizo string inside of an array$/) do
  expect(@metric_collector_names.include?("Analizo")).to be_truthy
end

Then(/^I should get "(.+)" metric collector$/) do |name|
  expect(@response.name).to eq(name)
end

Then(/^I should get an error$/) do
  expect(@is_error).to be_truthy
end
