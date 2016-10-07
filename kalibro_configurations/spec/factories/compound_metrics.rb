FactoryGirl.define do
  factory :compound_metric, class: CompoundMetricSnapshot do
    type 'CompoundMetricSnapshot'
    name 'Attack Surface'
    description 'How much of your can subject to attacks'
    code 'atks'
    scope 'CLASS'
    script 'return noa()/npa();'
  end
end
