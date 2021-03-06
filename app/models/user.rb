class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  NAME_KANA_REGEX = /\A[ァ-ン]+\z/.freeze

  with_options presence: true do
    validates_format_of :password, with: PASSWORD_REGEX, messages: 'パスワードは6文字以上で半角英字、半角数字の両方含めてください',
                                  length: { minimum: 6 }
    validates :first_name, format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :last_name, format: { with: NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :first_name_kana, format: { with: NAME_KANA_REGEX, message: 'は全角（カタカナ）で入力してください' }
    validates :last_name_kana, format: { with: NAME_KANA_REGEX, message: 'は全角（カタカナ）で入力してください' }
    validates :birth_date
    validates :nickname
  end

  has_many :items
  has_many :orders
end
