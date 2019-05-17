FactoryBot.define do
  factory :accessory_compatibility do
    association :stuffed_animal
    association :accessory
  end
end
