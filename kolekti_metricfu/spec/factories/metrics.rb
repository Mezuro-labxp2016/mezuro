FactoryGirl.define do
  factory :metric, class: KalibroClient::Entities::Miscellaneous::Metric do
    name 'Afferent Connections per Class (used to calculate COF - Coupling Factor)'
    code 'acc'
    type 'TestMetricSnapshot'
    scope { { 'type' => :SOFTWARE } }

    initialize_with { new(type, name, code, scope) }

    # Native metric base factories

    trait :native do
      type 'NativeMetricSnapshot'
      languages [:C]
    end

    trait :hotspot do
      type 'HotspotMetricSnapshot'
      scope { { 'type' => 'SOFTWARE' } }
      languages [:RUBY]
    end

    factory :native_metric, class: KalibroClient::Entities::Miscellaneous::NativeMetric do
      native

      name 'Native Metric'
      code 'NM'
      description 'A native metric'
      metric_collector_name 'NativeTestCollector'

      initialize_with { new(name, code, scope, languages, metric_collector_name) }
    end

    factory :hotspot_metric, class: KalibroClient::Entities::Miscellaneous::HotspotMetric do
      hotspot

      name 'Hotspot Metric'
      code 'HM'
      description 'A hotspot metric'
      metric_collector_name 'HotspotTestCollector'

      initialize_with { new(name, code, languages, metric_collector_name) }
    end

    trait :metric_fu do
      languages [:RUBY]
      metric_collector_name 'MetricFu'
      scope { { 'type' => 'METHOD' } }
    end

    factory :flog_metric, parent: :native_metric do
      metric_fu

      name 'Pain'
      code :flog
    end

    factory :saikuro_metric, parent: :native_metric do
      metric_fu

      name 'Cyclomatic Complexity'
      code :saikuro
    end

    factory :flay_metric, parent: :hotspot_metric do
      metric_fu

      name 'Duplicate Code'
      code :flay
      scope { { 'type' => 'SOFTWARE' } }
    end
  end
end
