require 'rails_helper'

RSpec.describe UserOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @user_order = FactoryBot.build(:user_order, user_id: @user.id, item_id: @item.id)
    
  end
  describe '配送先の入力情報' do

    context '配送先の入力情報が保存できる場合' do

      it '必要な全ての項目の入力ができていれば保存できる' do
        expect(@user_order).to be_valid
      end

      it '建物名の入力がなくても保存できる' do
        @user_order.apartment = ""
        expect(@user_order).to be_valid
      end
    end

    context '配送先の情報が保存でいない場合' do

      it '郵便番号は必須であること' do
        @user_order.postal_code = ""
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank", "Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号はハイフンが必要であること' do
        @user_order.postal_code = "1234567"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号は数字3桁、ハイフン、数字4桁での入力が必要であること' do
        @user_order.postal_code = "12-34567"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '郵便番号は半角数字であること' do
        @user_order.postal_code = "１２３-４５６７"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '市区町村は日本語であること' do
        @user_order.city = "NewYork"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City is incorrect")
      end
      it '市区町村は必須であること' do
        @user_order.city = ""
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank", "City is incorrect")
      end
      it '番地は必須であること' do
        @user_order.address =""
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号は必須であること' do
        @user_order.phone_number = ""
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number can't be blank", "Phone number is invalid.")
      end
      it '電話番号は１０〜１１桁での入力が必要であること' do
        @user_order.phone_number = "123456789"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number is invalid.")
      end
      it '電話番号は半角数字であること' do
        @user_order.phone_number = "０９０１２３４５６７８"
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number is invalid.")
      end
      it '都道府県の入力は必須であること' do
        @user_order.prefecture_id = 0
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'クレジットカード情報が空では登録できない' do
        @user_order.token = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idがないと登録できない' do
        @user_order.user_id = ""
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idがないと登録できない' do
        @user_order.item_id = ""
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end