### users テーブル

| Column        | Type    | Options                   |
| ------------- | ------- | ------------------------- |
| id (PK)       | integer | NOT NULL, PRIMARY KEY     |
| name          | string  | NOT NULL                  |
| email         | string  | NOT NULL, UNIQUE          |
| password_digest | string | NOT NULL                  |
| address       | string  |                           |
| phone_number  | string  |                           |
| created_at    | datetime| NOT NULL                  |
| updated_at    | datetime| NOT NULL                  |

#### アソシエーション

- 1対多の関係:
  - has_many :products, foreign_key: 'seller_id'
  - has_many :purchases, foreign_key: 'buyer_id'

### products テーブル

| Column            | Type    | Options                   |
| ----------------- | ------- | ------------------------- |
| id (PK)           | integer | NOT NULL, PRIMARY KEY     |
| name              | string  | NOT NULL                  |
| description       | text    | NOT NULL                  |
| price             | integer | NOT NULL                  |
| seller_id (FK)    | integer | NOT NULL, FOREIGN KEY     |
| category_id (FK)  | integer |                           |
| condition_id (FK) | integer |                           |
| shipping_id (FK)  | integer |                           |
| region_id (FK)    | integer |                           |
| shipping_days_id (FK) | integer |                       |
| created_at        | datetime| NOT NULL                  |
| updated_at        | datetime| NOT NULL                  |

#### アソシエーション

- 多対1の関係:
  - belongs_to :user, foreign_key: 'seller_id'
- 1対多の関係:
  - has_many :purchases
  - has_many :shipping_addresses, through: :purchases

### purchases テーブル

| Column          | Type    | Options                   |
| --------------- | ------- | ------------------------- |
| id (PK)         | integer | NOT NULL, PRIMARY KEY     |
| product_id (FK) | integer | NOT NULL, FOREIGN KEY     |
| buyer_id (FK)   | integer | NOT NULL, FOREIGN KEY     |
| purchased_at    | datetime| NOT NULL                  |
| payment_method  | string  |                           |

#### アソシエーション

- 多対1の関係:
  - belongs_to :product
  - belongs_to :user, foreign_key: 'buyer_id'
- 1対1の関係:
  - has_one :shipping_address

### shipping_addresses テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| id (PK)            | integer | NOT NULL, PRIMARY KEY     |
| purchase_id (FK)   | integer | NOT NULL, FOREIGN KEY     |
| postal_code        | string  |                           |
| address            | string  |                           |
| recipient_name     | string  |                           |
| recipient_phone    | string  |                           |
| created_at         | datetime| NOT NULL                  |
| updated_at         | datetime| NOT NULL                  |

#### アソシエーション

- 1対1の関係:
  - belongs_to :purchase

