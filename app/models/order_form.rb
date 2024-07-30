class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :region_id, :city, :street_address, :building_name, :recipient_phone, :token

  validates :token, presence: { message: 'を入力してください' }
  validates :user_id, presence: { message: 'を入力してください' }
  validates :item_id, presence: { message: 'を入力してください' }
  validates :postal_code, presence: { message: 'を入力してください' }, format: { with: /\A\d{3}-\d{4}\z/, message: 'は半角数字で「例：123-4567」のように入力してください' }
  validates :region_id, presence: { message: 'を選択してください' }, numericality: { other_than: 1, message: 'を選択してください' }
  validates :city, presence: { message: 'を入力してください' }
  validates :street_address, presence: { message: 'を入力してください' }
  validates :recipient_phone, presence: { message: 'を入力してください' }, format: { with: /\A\d{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください' }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      postal_code: postal_code, region_id: region_id, city: city,
       street_address: street_address, building_name: building_name,
        recipient_phone: recipient_phone, purchase_id: purchase.id
        )
  end
end
