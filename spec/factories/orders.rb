FactoryBot.define do
  factory :order do
    completed_at { Faker::Date.between(20.days.ago, Date.today) }
    total { Faker::Number.decimal(2) }
  end
end
