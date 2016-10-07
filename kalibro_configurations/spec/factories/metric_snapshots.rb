FactoryGirl.define do
  factory :metric_snapshot do
    type 'NativeMetricSnapshot'
    name 'Lines of Code'
    description ''
    code 'loc'
    metric_collector_name 'Analizo'
    scope { {'type' => 'CLASS'} }
  end
end
