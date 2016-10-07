FactoryGirl.define do
  factory :metric_configuration do
    metric_snapshot { FactoryGirl.build(:metric_snapshot) }
    kalibro_configuration { FactoryGirl.build(:kalibro_configuration) }

    trait :tree do
      weight 1.5
      aggregation_form 'MyString'
      reading_group_id 1
    end

    trait :hotspot do
      metric_snapshot { FactoryGirl.build(:hotspot_metric_snapshot) }
    end

    trait :with_id do
      id 33
    end

    factory :tree_metric_configuration_with_id, traits: [:tree, :with_id]
    factory :tree_metric_configuration, traits: [:tree]
    factory :hotspot_metric_configuration_with_id, traits: [:hotspot, :with_id]
    factory :hotspot_metric_configuration, traits: [:hotspot]
  end
end
