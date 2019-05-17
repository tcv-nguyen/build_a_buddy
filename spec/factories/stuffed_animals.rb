FactoryBot.define do
  factory :stuffed_animal do
    name { Faker::Lorem.word }
    cost { Faker::Number.decimal(2) }
    sale_price { Faker::Number.decimal(2) }
    quantity { Faker::Number.number(3) }
  end
end
