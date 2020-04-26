require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.create(:post)
  end

  it 'post modelが有効な状態かテスト'do
    expect(@post).to be_valid
  end

  describe 'カラムごとのテスト' do
    describe 'imageに関するテスト' do
      it '画像がない場合許可しない' do
        @post.image = nil
        @post.valid?
        expect(@post.errors).to be_added(:image, :blank)
      end
    end

    describe 'descriptionに関するテスト' do
      it 'キャプションがない場合許可しない' do
        @post.description = nil
        @post.valid?
        expect(@post.errors).to be_added(:description, :blank)
      end

      it 'キャプションが141文字以上の場合許可しない' do
        @post.description = 'a' * 141
        @post.valid?
        expect(@post.errors).to be_added(:description, :too_long, count: 140)
      end
    end

    describe 'user_idに関するテスト' do
      it 'user_idがなければ許可しない' do
        @post.user_id = nil
        @post.valid?
        expect(@post).not_to be_valid
      end
    end
  end
end
