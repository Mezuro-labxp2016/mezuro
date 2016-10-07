FactoryGirl.define do
  factory :kalibro_range do
    beginning 0.5
    self.end 1.5
    comments 'Range comments'
    reading { FactoryGirl.build(:reading) }
    metric_configuration { FactoryGirl.build(:metric_configuration) }

    trait :with_id do
      id 32
    end

    trait :with_another_interval do
      beginning 1.6
      self.end 2.5
    end

    factory :kalibro_range_with_id, traits: [:with_id]
    factory :kalibro_range_with_another_interval, traits: [:with_another_interval]
    factory :kalibro_range_with_another_interval_with_id, traits: [:with_another_interval, :with_id]
  end
end
