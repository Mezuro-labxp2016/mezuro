FactoryGirl.define do
  factory :hotspot_metric_snapshot do
    type 'HotspotMetricSnapshot'
    name 'Flay'
    description ''
    code 'flay'
    metric_collector_name 'MetricFu'
    scope { {'type' => 'SOFTWARE'} }
  end
end
