require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '内容に問題がない場合' do
      it 'ニックネーム、メールアドレス、パスワード、名字、名前、フリガナ、生年月日が必須である' do
        expect(@user).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'メールアドレスは一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは、＠を含むこと' do
        @user.email = 'aaaaaa.a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワードは不正な値です", "パスワード（確認用）とパスワードの入力が一致しません")
      end
      
      it 'パスワードは数字のみでは登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'パスワードは英語のみでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'パスワードは全角では登録できないこと' do
        @user.password = '１２３４５６'
        @user.password_confirmation = '１２３４５６'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end
      it 'パスワードが存在しても確認用パスワードが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'パスワードとパスワードの確認、値が一致が必須であること' do
        @user.password = '000aaa'
        @user.password_confirmation = '000bbb'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'ユーザー名の名前は必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前は全角（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'ユーザー名の名字は必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください", "名字は全角（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'ユーザー名（名前）は全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = '1aA'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'ユーザー名（名字）は全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.last_name = '2bB'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'ユーザー名の名前のフリガナは必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（カナ）を入力してください", "お名前（カナ）は全角（カタカナ）で入力してください")
      end
      it 'ユーザー名の名字のフリガナは必須であること' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）を入力してください", "名字（カナ）は全角（カタカナ）で入力してください")
      end
      it 'ユーザー名の名前のフリガナは全角（カタカナ）での入力が必須であること' do
        @user.first_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前（カナ）は全角（カタカナ）で入力してください")
      end
      it 'ユーザー名の名字のフリガナは全角（カタカナ）での入力が必須であること' do
        @user.last_name_kana = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）は全角（カタカナ）で入力してください")
      end
      it '生年月日が必須であること' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
