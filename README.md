### users テーブル

| Column        | Type    | Options                   |
| ------------- | ------- | ------------------------- |
| nickname      | string  | null: false               |
| last_name     | string  | null: false               |
| first_name    | string  | null: false               |
| last_name_kana  | string  | null: false               |
| first_name_kana | string  | null: false               |
| email         | string  | null: false, unique: true        |
| encrypted_password | string | null: false               |
| birth_date         | date    | null: false               |

#### アソシエーション

- 1対多の関係:
  - has_many :products, foreign_key: 'seller_id'
  - has_many :purchases, foreign_key: 'buyer_id'

### products テーブル

| Column            | Type    | Options                   |
| ----------------- | ------- | ------------------------- |
| name              | string  | null: false                  |
| description       | text    | null: false                  |
| price             | integer | null: false                  |
| user              | references | null: false, foreign_key: true|
| category_id       | integer | null: false               |
| condition_id      | integer | null: false               |
| shipping_id       | integer | null: false               |
| region_id         | integer | null: false               |
| shipping_day_id   | integer | null: false           |

#### アソシエーション

- 多対1の関係:
  - belongs_to :user, foreign_key: 'seller_id'
- 1対1の関係:
  - has_one :purchases

### purchases テーブル

| Column          | Type    | Options                   |
| --------------- | ------- | ------------------------- |
| product         | references | null: false, foreign_key: true    |
| user            | references | null: false, foreign_key: true     |


#### アソシエーション

- 多対1の関係:
  - belongs_to :user, foreign_key: 'buyer_id'
- 1対1の関係:
  - has_one :shipping_address
  - has_one :product

### shipping_addresses テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| purchase           | references | null: false, foreign_key: true     |
| postal_code        | string  | null: false               |
| recipient_phone    | string  | null: false               |
| region_id          | integer | null: false                |  
| city               | string  | null: false                |  
| street_address     | string  | null: false                |  
| building_name      | string  |                            |  

#### アソシエーション

- 1対1の関係:
  - belongs_to :purchase

