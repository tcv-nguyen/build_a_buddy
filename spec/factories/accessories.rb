FactoryBot.define do
  factory :accessory do
    name { Faker::Lorem.word }
    size { Faker::Lorem.word }
    cost { "9.99" }
    sale_price { "9.99" }
  end
end
