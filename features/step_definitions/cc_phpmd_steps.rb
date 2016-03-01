Given(/^PHPMD is registered on Kolekti$/) do
  Kolekti.register_collector(Kolekti::CcPhpMd::Collector)
end

Given(/^I have a set of wanted metrics for PHPMD$/) do
  #acc_metric = FactoryGirl.build(:acc_metric)
  #tac_metric = FactoryGirl.build(:total_abstract_classes_metric)
  @wanted_metric_configurations = [
  #  FactoryGirl.build(:metric_configuration, metric: acc_metric),
  #  FactoryGirl.build(:metric_configuration, metric: tac_metric)
  ]
end
