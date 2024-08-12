FactoryBot.define do
  factory :order_form do
    postal_code { '123-4567' }
    region_id { 2 }
    city { '横浜市' }
    street_address { '青山1-1-1' }
    building_name { '柳ビル103' }
    recipient_phone { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
