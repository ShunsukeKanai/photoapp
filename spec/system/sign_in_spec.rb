require 'rails_helper'

RSpec.describe 'SignIn', type: :system do
  before do
    user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
  end
  
  it 'ログインに失敗する' do
    # パスワードを間違える
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'a@example.com'
    fill_in 'パスワード', with: 'fakepassword'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレスまたはパスワードが違います。'
  end

  it 'ユーザーAでログインする' do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'a@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_selector '.alert-success', text: 'ログインしました。'
  end
end