require 'rails_helper'

RSpec.describe 'SignUp', type: :system do
  before do
    ActionMailer::Base.deliveries.clear
    user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
  end

  it '新規登録に失敗する' do
    visit new_user_registration_path
    # すでに使用されているユーザーネームを使用する
    fill_in 'ユーザーネーム', with: 'ユーザーA'
    # メールアドレスの文字列が形式にそっていない
    fill_in 'メールアドレス', with: 'a@a'
    # パスワードが空欄
    fill_in 'パスワード', with: ''
    # 確認用パスワードがパスワードと異なる
    fill_in '確認用パスワード', with: 'password'
    click_button 'アカウント作成'
    expect(page).to have_content 'ユーザーネームはすでに存在します'
    expect(page).to have_content 'メールアドレスは不正な値です'
    expect(page).to have_content 'パスワードを入力してください'
    expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'

    # すでに登録されているメールアドレスを使用する
    fill_in 'ユーザーネーム', with: 'ユーザーB'
    fill_in 'メールアドレス', with: 'a@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in '確認用パスワード', with: 'password'
    click_button 'アカウント作成'
    expect(page).to have_content 'メールアドレスはすでに存在します'
  end

  it '新規登録に成功する' do
    visit new_user_registration_path
    fill_in 'ユーザーネーム', with: 'テストユーザー'
    fill_in 'メールアドレス', with: 'testuser@example.com'
    fill_in 'パスワード', with: 'password'
    fill_in '確認用パスワード', with: 'password'
    click_button 'アカウント作成'
    expect(page).to have_selector '.alert-success', text: '本人確認用のメールを送信しました。'

  end
end