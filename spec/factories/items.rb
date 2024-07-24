FactoryBot.define do
  factory :item do
    name { "テスト商品" }
    description { "商品の説明" }
    price { 5000 }
    association :user
    category_id { 2 }
    condition_id { 2 }
    shipping_id { 2 }
    region_id { 2 }
    shipping_day_id { 2 }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/test.png'), 'image/png') }
  end
end
