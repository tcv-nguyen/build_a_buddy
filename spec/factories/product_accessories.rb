FactoryBot.define do
  factory :product_accessory do
    association :custom_product
    association :accessory
    accessory_price { accessory.sale_price }
  end
end
