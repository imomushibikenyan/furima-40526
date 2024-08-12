require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item) 
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it '全ての情報が正しく入力されていれば保存できる' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では保存できない' do
        @order_form.token = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token を入力してください")
      end

      it 'user_idが空では保存できない' do
        @order_form.user_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User を入力してください")
      end

      it 'item_idが空では保存できない' do
        @order_form.item_id = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item を入力してください")
      end

      it 'postal_codeが空では保存できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code を入力してください")
      end

      it 'postal_codeが「3桁ハイフン4桁」の形式でなければ保存できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code は半角数字で「例：123-4567」のように入力してください")
      end

      it 'region_idが1では保存できない' do
        @order_form.region_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Region を選択してください")
      end

      it 'cityが空では保存できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City を入力してください")
      end

      it 'street_addressが空では保存できない' do
        @order_form.street_address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Street address を入力してください")
      end

      it 'recipient_phoneが空では保存できない' do
        @order_form.recipient_phone = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Recipient phone を入力してください")
      end

      it 'recipient_phoneが10桁未満では保存できない' do
        @order_form.recipient_phone = '090123456'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Recipient phone は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'recipient_phoneが12桁以上では保存できない' do
        @order_form.recipient_phone = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Recipient phone は10桁以上11桁以内の半角数値で入力してください")
      end

      it 'recipient_phoneにハイフンが含まれていると保存できない' do
        @order_form.recipient_phone = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Recipient phone は10桁以上11桁以内の半角数値で入力してください")
      end
    end
  end
end
