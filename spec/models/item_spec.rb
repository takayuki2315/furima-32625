require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品投稿機能' do

    context '商品投稿が成功する場合' do

      it '全ての項目の入力ができていれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品投稿が失敗する場合' do
      it '商品画像がないと投稿できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'ユーザーと商品が紐付いていないと投稿できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Userを入力してください")
      end
      it '商品名がないと投稿できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明がないと投稿できない' do
        @item.text = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'カテゴリーの情報がないと投稿できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it '商品の状態についての情報がないと投稿できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it '配送料の負担についての情報がないと投稿できない' do
        @item.delivery_fee_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it '発送元の地域についての情報がないと投稿できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it '発送までの日数についての情報がないと投稿できない' do
        @item.days_to_delivery_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it '商品価格の情報がないと保存できない' do
        @item.price = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は（¥300〜9,999,999）の間で設定してください", "価格は不正な値です")
      end
      it '商品の価格は￥３００以上でないと投稿できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は（¥300〜9,999,999）の間で設定してください")
      end
      it '商品の価格は￥９,９９９,９９９以下でないと投稿できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は（¥300〜9,999,999）の間で設定してください")
      end
      it '商品の価格は半角数字での入力でないと投稿できない' do
        @item.price = "aあ商品アｱ"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は（¥300〜9,999,999）の間で設定してください")
      end
    end
  end
end
