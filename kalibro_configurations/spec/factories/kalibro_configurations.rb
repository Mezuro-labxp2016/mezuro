FactoryGirl.define do
  factory :kalibro_configuration do
    name 'My Configuration'
    description 'Sample description'

    trait :with_id do
      id 25
    end

    factory :kalibro_configuration_with_id, traits: [:with_id]
  end
end
