FactoryBot.define do
  factory :stuffed_animal do
    name { Faker::Lorem.word }
    cost { "9.99" }
    sale_price { "9.99" }
  end
end
