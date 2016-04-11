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

    trait :flog do
      metric { FactoryGirl.build(:flog_metric) }
    end

    trait :saikuro do
      metric { FactoryGirl.build(:saikuro_metric) }
    end

    trait :flay do
      hotspot
      metric { FactoryGirl.build(:flay_metric) }
    end

    factory :flog_metric_configuration, traits: [:flog]
  end
end
