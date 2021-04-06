FactoryBot.define do
  factory :review do
    summary {Faker::Lorem.sentence}
    impressions {Faker::Lorem.sentence}
    plan {Faker::Lorem.sentence}
    association :user
    association :book 
  end
end
