When (/^I request the metric_percentage$/) do
  @metric_percentage = KalibroClient::Entities::Configurations::Statistic.metric_percentage(@metric.code)
end

Then (/^I should get a hash containing a real number$/) do
  expect(@metric_percentage["metric_percentage"]).to be_a(Float)
end
