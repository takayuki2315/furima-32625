FactoryBot.define do
  factory :user_order do
    postal_code    { '123-4567' }
    prefecture_id  { 1 }
    city           { '富士見市' }
    address        { '478-2' }
    apartment      { 'たま'}
    phone_number   { '09053100327'}
    user_id        { 1 }
    item_id        { 1 }
    order_id       { 1 }
    token          { "tok_abcdefghijk00000000000000000" }
  end
end