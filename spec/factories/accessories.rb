FactoryBot.define do
  factory :accessory do
    name { Faker::Lorem.word }
    size { Faker::Lorem.word }
    cost { Faker::Number.decimal(2) }
    sale_price { Faker::Number.decimal(2) }
    quantity { Faker::Number.number(3) }
  end
end
