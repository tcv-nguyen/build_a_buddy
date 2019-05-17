FactoryBot.define do
  factory :custom_product do
    association :order
    price { Faker::Number.decimal(2) }
  end
end
