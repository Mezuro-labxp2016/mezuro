FactoryGirl.define do
  factory :reading do
    label 'Reading'
    grade 1.5
    color 'FF0000'
    reading_group { FactoryGirl.build(:reading_group) }

    trait :with_id do
      id 30
    end

    factory :reading_with_id, traits: [:with_id]
  end
end
