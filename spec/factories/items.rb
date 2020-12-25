FactoryBot.define do
  factory :item do
    name                {Faker::Lorem.sentence}
    text                {Faker::Lorem.sentence}
    category_id         {1}
    condition_id        {1} 
    delivery_fee_id     {1} 
    prefecture_id       {1}
    days_to_delivery_id {1}
    price               {1000}
    
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
