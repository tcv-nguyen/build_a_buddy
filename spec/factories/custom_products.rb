FactoryBot.define do
  factory :custom_product do
    association :order
    association :stuffed_animal
    price { Faker::Number.decimal(2) }
    stuffed_animal_price { stuffed_animal.sale_price }
  end
end
