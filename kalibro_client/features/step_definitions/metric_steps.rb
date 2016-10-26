Given(/^I have a metric with name "(.*?)"$/) do |name|
  @metric = FactoryGirl.build(:metric, {name: name})
end
