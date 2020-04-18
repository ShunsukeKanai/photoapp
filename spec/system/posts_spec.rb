require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  # before do
  #   let!(:post_a) { FactoryBot.create(:post, description: '初投稿' , user: user_a) }
  #   let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  #   let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  #   visit login_path
  #   fill_in 'メールアドレス', with: login_user.email
  #   fill_in 'パスワード', with: login_user.password
  #   click_button 'ログイン'
  #   user_a = FactoryBot.create(:use, name: 'ユーザーA', email: 'a@example.com')
  #   visit login_path
  #   fill_in 'メールアドレス', with: 'a@example.com'
  #   fill_in 'パスワード', with: 'password'
  #   click_button 'ログイン'
  # end

  describe '投稿関連機能' do
    before do
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'a@example.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      # visit new_post_path
      # attach_file 'ファイルを選択', "#{Rails.root}/spec/fixtures/test.jpg"
      # fill_in 'キャプションを入力', with: post_context
      # click_button '投稿'
    end

    it '新規投稿' do
      visit new_post_path
      attach_file 'post_image',"#{Rails.root}/spec/fixtures/test.png"
      fill_in 'キャプションを入力', with: '投稿テスト'
      click_button '投稿'
      expect(page).to have_selector '.alert-success', text: '投稿を完了しました'
    end


    # context '画像とキャプション両方入力したとき' do
    #   let(:post_context){'good'}

    #   it '正常に投稿される' do
    #     expect(page).to have_selector '.alert-success', text: '投稿を完了しました'
    #   end
    # end
    # context '画像とキャプション両方入力しなかったとき' do
    #   let(:post_context) { '' }

    #   it 'エラーになる' do
    #     within 'error_explanation'
    #     expect(page).to have_content 'キャプションを入力していください'
    #   end
    # end
  end
end
