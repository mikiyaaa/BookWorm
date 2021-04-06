FactoryBot.define do
  factory :book do
    isbn {Faker::Number.number(digits: 13)}
    title {'タイトル'}
    author {'著者'}
    caption {'説明文'}
    image_url {'public/images/white_00073.jpg'}
    url {'http://example.com'}
    association :user
    
  end
end