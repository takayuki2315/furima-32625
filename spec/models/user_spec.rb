require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      it 'ニックネーム、メールアドレス、パスワード、名字、名前、フリガナ、生年月日が必須である' do
        expect(@user).to be_valid
      end
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスは一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、＠を含むこと' do
        @user.email = 'aaaaaa.a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字以上であれば登録できる' do
        @user.password = 'a12345'
        @user.password_confirmation = 'a12345'
        expect(@user).to be_valid
      end
      it 'パスワードは半角英数混合での入力が必要であること' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'パスワードが存在しても確認用パスワードが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワードの確認、値が一致が必須であること' do
        @user.password = '000aaa'
        @user.password_confirmation = '000aaa'
        expect(@user).to be_valid
      end
      it 'ユーザー本名は名字と名前がそれぞれ必須であること' do
        @user.first_name = ''
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name First name Full-width characters', "Last name can't be blank",
                                                      'Last name Last name Full-width characters')
      end
      it 'ユーザー名は全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = '1aA'
        @user.last_name = '2bB'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name First name Full-width characters',
                                                      'Last name Last name Full-width characters')
      end
      it 'ユーザー名のフリガナは名字と名前でそれぞれ必須であること' do
        @user.first_name_kana = 'カタカナ'
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank",
                                                      'Last name kana Last name kana Full-width katakana characters')
      end
      it 'ユーザー本名のフリガナは全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'タロウ'
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
      it '生年月日が必須であること' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
