FactoryGirl.define do
  factory :metric_configuration, class: KalibroClient::Entities::Configurations::MetricConfiguration do
    metric { FactoryGirl.build(:metric) }
    weight 1
    aggregation_form "mean"
    reading_group_id 1
    kalibro_configuration_id 1

    trait :with_id do
      sequence(:id, 1)
    end

    trait :hotspot do
      reading_group_id nil
      aggregation_form nil
      weight nil
    end

    trait :cyclomatic do
      metric { FactoryGirl.build(:cyclomatic_metric) }
    end

    trait :maintainability do
      metric { FactoryGirl.build(:maintainability_metric) }
    end

    trait :lines_of_code do
      metric { FactoryGirl.build(:lines_of_code_metric) }
    end

    trait :logical_lines_of_code do
      metric { FactoryGirl.build(:logical_lines_of_code_metric) }
    end

    factory :cyclomatic_metric_configuration, traits: [:cyclomatic]
    factory :maintainability_metric_configuration, traits: [:maintainability]
    factory :lines_of_code_metric_configuration, traits: [:lines_of_code]
    factory :logical_lines_of_code_metric_configuration, traits: [:logical_lines_of_code]
  end
end
