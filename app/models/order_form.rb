class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :region_id, :city, :street_address, :building_name, :recipient_phone, :token

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :region_id, presence: true, numericality: { other_than: 1 }
  validates :city, presence: true
  validates :street_address, presence: true
  validates :recipient_phone, presence: true, format: { with: /\A\d{10,11}\z/ }
  validates :token, presence: true

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, region_id: region_id, city: city, street_address: street_address, building_name: building_name, recipient_phone: recipient_phone, purchase_id: purchase.id)
  end
end
