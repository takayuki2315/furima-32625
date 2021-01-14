class UserOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :apartment, :phone_number, :user_id, :item_id, :token


  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}[-][0-9]{4}\z/, message: "が正しくありません。ハイフン(-)を含めてください" }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "が正しくありません" }
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "を半角数字で入力してください" }
    validates :user_id
    validates :item_id
    validates :prefecture_id, numericality: { other_than: 0, message: "を選択してください" }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, apartment: apartment, phone_number: phone_number, order_id: order.id)
  end
end