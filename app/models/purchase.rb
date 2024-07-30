class Purchase < ApplicationRecord
  belongs_to :user, foreign_key: 'buyer_id'
  belongs_to :item
  has_one :shipping_address, dependent: :destroy

  validates :user_id, presence: true
  validates :item_id, presence: true
end
