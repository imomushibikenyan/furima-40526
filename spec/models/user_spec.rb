require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      user = User.new(nickname: 'test', email: '', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが一意性であること' do
      User.create(nickname: 'test1', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                  last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user = User.new(nickname: 'test2', email: 'test@example.com', password: 'test456', password_confirmation: 'test456',
                      last_name: '田中', first_name: '花子', last_name_kana: 'タナカ', first_name_kana: 'ハナコ', birth_date: '2001-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'emailが＠を含む必要があること' do
      user = User.new(nickname: 'test', email: 'testexample.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Email is invalid")
    end

    it 'passwordが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: '', password_confirmation: '',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: '12345', password_confirmation: '12345',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'passwordが半角英字と数字の両方を含まない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password は半角英字と数字の両方を含む必要があります")
    end

    it 'passwordとpassword_confirmationが一致しない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'mismatch123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'last_nameが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_nameが全角文字でない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: 'yamada', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Last name 全角文字を使用してください")
    end

    it 'first_nameが全角文字でない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: 'taro', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name 全角文字を使用してください")
    end

    it 'last_name_kanaが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: '', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'first_name_kanaが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: '', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'last_name_kanaが全角カタカナでない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'やまだ', first_name_kana: 'タロウ', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Last name kana 全角カタカナを使用してください")
    end

    it 'first_name_kanaが全角カタカナでない場合は登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'たろう', birth_date: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana 全角カタカナを使用してください")
    end

    it 'birth_dateが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'test123', password_confirmation: 'test123',
                      last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birth_date: '')
      user.valid?
      expect(user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
