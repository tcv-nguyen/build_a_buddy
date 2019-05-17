FactoryBot.define do
  factory :order do
    completed_at { Faker::Date.between(20.days.ago, Date.today) }
    total { Faker::Number.decimal(2) }

    transient do
      product_count { 1 }
    end

    trait :with_custom_product do
      after(:create) do |order, evaluator|
        create_list(:custom_product, evaluator.product_count, order_id: order.id)
      end
    end
  end
end
