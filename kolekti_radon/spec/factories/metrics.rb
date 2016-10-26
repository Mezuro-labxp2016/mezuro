FactoryGirl.define  do
  factory :metric, class: KalibroClient::Entities::Miscellaneous::Metric do
    name "Afferent Connections per Class (used to calculate COF - Coupling Factor)"
    code "acc"
    type 'TestMetricSnapshot'
    scope { { "type" => :SOFTWARE } }

    initialize_with { new(type, name, code, scope) }

    # Native metric base factories

    trait :native do
      type 'NativeMetricSnapshot'
      languages [:C]
    end

    trait :hotspot do
      type 'HotspotMetricSnapshot'
      scope { { "type" => "SOFTWARE" } }
      languages [:RUBY]
    end

    factory :native_metric, class: KalibroClient::Entities::Miscellaneous::NativeMetric do
      native

      name "Native Metric"
      code "NM"
      description "A native metric"
      metric_collector_name 'NativeTestCollector'

      initialize_with { new(name, code, scope, languages, metric_collector_name) }
    end

    factory :hotspot_metric, class: KalibroClient::Entities::Miscellaneous::HotspotMetric do
      hotspot

      name "Hotspot Metric"
      code "HM"
      description "A hotspot metric"
      metric_collector_name 'HotspotTestCollector'

      initialize_with { new(name, code, languages, metric_collector_name) }
    end

    trait :radon do
      languages [:PYTHON]
      metric_collector_name "Radon"
      scope { { "type" => :METHOD } }
    end

    factory :cyclomatic_metric, parent: :native_metric do
      radon

      name "Cyclomatic Complexity"
      code 'cc'
    end

    factory :maintainability_metric, parent: :native_metric do
      radon

      name "Maintainability Index"
      code 'mi'
      scope { { "type" => :PACKAGE } }
    end

    factory :lines_of_code_metric, parent: :native_metric do
      radon

      name "Lines of code"
      code 'loc'
      scope { { "type" => :PACKAGE } }
    end

    factory :logical_lines_of_code_metric, parent: :native_metric do
      radon

      name "Logical lines of code"
      code 'lloc'
      scope { { "type" => :PACKAGE } }
    end
  end
end
