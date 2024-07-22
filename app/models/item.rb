class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_day
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :description
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
    validates :category_id, numericality: { other_than: 1 }
    validates :condition_id, numericality: { other_than: 1 }
    validates :shipping_id, numericality: { other_than: 1 }
    validates :region_id, numericality: { other_than: 1 }
    validates :shipping_day_id, numericality: { other_than: 1 }
  end
end
