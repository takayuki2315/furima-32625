class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :days_to_delivery

  belongs_to :user
  has_one_attached :image
  has_one :order

  with_options presence: true do
    validates :image, :name, :text
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is out of setting range" }
    validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_to_delivery_id, numericality: { other_than: 0 }
  end
  

  PRICE_REGEX = /\A[0-9]+\z/.freeze
  validates :price, format: { with: PRICE_REGEX }
end
