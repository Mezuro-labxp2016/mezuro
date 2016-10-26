Given(/^Radon is registered on Kolekti$/) do
  Kolekti.register_collector(Kolekti::Radon::Collector)
end
