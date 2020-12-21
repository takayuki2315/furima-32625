# Furimaのテーブル設計

##users テーブル

| Column             | Type   | Option                    |
| ------------------ | -----  | ------------------------- | 
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birth_date         | date   | null: false               |

### Association

- has_many :items
- has_many :orders

## itmes テーブル

| Column             | Type       | Option                         |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| text               | text       | null: false                    |
| category_id        | integer    | null: false                    |
| condition_id       | integer    | null: false                    |
| delivery_fee_id    | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| day_to_delivery_id | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :category_id
- belongs_to :condition_id
- belongs_to :delivery_fee_id
- belongs_to :prefecture_id
- belongs_to :day_to_delivery_id
- has_one :order

## orders テーブル

| Column    | Type       | Option                         |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column        | Type       | Option                         |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| apartment     | string     |                                |
| phone_number  | string     | null: false                    |

### Association

- belongs_to :order
- belongs_to: prefecture_id