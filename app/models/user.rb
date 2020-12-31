class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ン]+\z/.freeze

  with_options presence: true do
    validates_format_of :password, with: PASSWORD_REGEX, messages: 'Password Include both letters and numbers',
                                  length: { minimum: 6 }
    validates :first_name, format: { with: NAME_REGEX, message: 'First name Full-width characters' }
    validates :last_name, format: { with: NAME_REGEX, message: 'Last name Full-width characters' }
    validates :first_name_kana, format: { with: NAME_KANA_REGEX, message: 'First name kana Full-width katakana characters' }
    validates :last_name_kana, format: { with: NAME_KANA_REGEX, message: 'Last name kana Full-width katakana characters' }
    validates :birth_date
    validates :nickname
  end

  has_many :items
  has_many :orders
end
