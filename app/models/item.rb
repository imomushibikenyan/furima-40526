class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_day
  has_one_attached :image

  validates :name, presence: { message: "を入力してください" }
  validates :description, presence: { message: "を入力してください" }
  validates :price, presence: { message: "を入力してください" }, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "は¥300〜¥9,999,999の間で入力してください" }
  validates :image, presence: { message: "をアップロードしてください" }
  validates :category_id, numericality: { other_than: 1, message: "は無効です" }, presence: { message: "を選択してください" }
  validates :condition_id, numericality: { other_than: 1, message: "は無効です" }, presence: { message: "を選択してください" }
  validates :shipping_id, numericality: { other_than: 1, message: "は無効です" }, presence: { message: "を選択してください" }
  validates :region_id, numericality: { other_than: 1, message: "は無効です" }, presence: { message: "を選択してください" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "は無効です" }, presence: { message: "を選択してください" }
end
