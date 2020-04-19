require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ユーザー登録が可能である' do
    expect(@user).to be_valid
  end

  describe 'カラムごとの検証' do
    describe 'name' do
      it 'nameがないユーザーを許可しない' do
        @user.name = nil
        @user.valid?
        expect(@user.errors).to be_added(:name, :blank)
      end
  
      it 'nameが31文字以上の場合許可しない' do
        @user.name = 'a' * 31
        @user.valid?
        expect(@user.errors).to be_added(:name, :too_long, count: 30)
      end
  
      it 'nameが他のユーザーと重複する場合許可しない' do
        user_a = FactoryBot.create(:user, name: 'test', email: 'a@example.com')
        user_b = FactoryBot.build(:user, name: 'test', email: 'b@example.com')
        user_b.valid?
        expect(user_b.errors).to be_added(:name, :taken, value: 'test')
      end
  
      it 'nameは小文字と大文字で区別する' do
        user_a = FactoryBot.create(:user, name: 'test', email: 'a@example.com')
        user_b = FactoryBot.build(:user, name: 'TEST', email: 'b@example.com')
        user_b.valid?
        expect(user_b).to be_valid
      end
    end

    describe 'email' do
      it 'emailがないユーザーを許可しない' do
        @user.email = nil
        @user.valid?
        expect(@user.errors).to be_added(:email, :blank)
      end
  
      it 'emailが重複する場合許可しない' do
        user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'test@example.com')
        user_b = FactoryBot.build(:user, name: 'ユーザーB', email: 'test@example.com')
        user_b.valid?
        expect(user_b.errors).to be_added(:email, :taken, value: 'test@example.com')
      end
  
      it 'emailが256文字以上の場合許可しない' do
        @user.email = 'a' * 244 + '@example.com'
        @user.valid?
        expect(@user.errors).to be_added(:email, :too_long, count: 255)
      end

      it 'メールアドレスが不正なフォーマットの場合許可しない' do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                               foo@bar_baz.com foo@bar+baz.com @example.com]
        invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          @user.valid?
          expect(@user.errors).to be_added(:email, :invalid, value: invalid_address)
        end
      end
    end

    describe 'password' do
      it 'passwordが6文字未満のユーザーを許可しない' do
        @user.password = 'a' * 5
        @user.valid?
        expect(@user.errors).to be_added(:password, :too_short, count: 6)
      end

      it 'passwordが６文字以上のユーザーを許可する' do
        @user.password = @user.password_confirmation = 'a' * 6
        expect(@user).to be_valid
      end

      it 'passwordとpasswordconfirmationが一致しない場合許可しない' do
        @user.password = 'password'
        @user.password_confirmation = 'aaaaaaaa'
        @user.valid?
        expect(@user.errors).to be_added(:password_confirmation, :confirmation, attribute: 'パスワード')
      end
    end
  end
end