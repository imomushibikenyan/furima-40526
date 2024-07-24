require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)  
    @item = FactoryBot.build(:item, user: @user)
  end

  describe '商品出品機能' do
    context '商品情報が正しく登録できるとき' do
      it '全ての情報が正しく入力されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品登録ができないとき' do
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name を入力してください")
      end

      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description を入力してください")
      end

      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price を入力してください")
      end

      it '価格が¥300未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の間で入力してください")
      end

      it '価格が¥9,999,999を超えると登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price は¥300〜¥9,999,999の間で入力してください")
      end

      it '画像が添付されていない場合は登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image をアップロードしてください")
      end

      it 'カテゴリーが未選択では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category は無効です")
      end

      it '商品の状態が未選択では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition は無効です")
      end

      it '配送料の負担が未選択では登録できない' do
        @item.shipping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping は無効です")
      end

      it '発送元の地域が未選択では登録できない' do
        @item.region_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Region は無効です")
      end

      it '発送までの日数が未選択では登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping day は無効です")
      end

      it 'ユーザーが紐付いていない場合は登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
    end
  end
end