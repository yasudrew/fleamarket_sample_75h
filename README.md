# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|email|string|null:false|
|password|string|null:false|

## アソシエーション
- has_one : profile dependent: : destroy
- has_one : card dependent: : destroy
- has_many : items dependent: : destroy
- has_many : comments


## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|card_id|string|null:false|
|customer_id|string|null:false|
|user_id|integer|null:false, foreign_key: true|

## アソシエーション
- belongs_to : user


## profileテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null:false|
|first_name|string|null:false|
|family_name_kana|string|null:false|
|first_name_kana|string|null:false|
|birth_day|date|null:false|
|post_code|string|null:false|
|prefecture|string|null:false|
|city|string|null:false|
|address|string|null:false|
|building_name|string||
|user_id|integer|null:false, foreign_key: true|

## アソシエーション
- belongs_to: user


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|||
|user_id|integer|null:false  foreign_key: true|
|item_id|integer|null:false  foreign_key: true|

## アソシエーション
- belongs_to: user
- belongs_to: item


## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|description|text|null:false|
|status|integer|null:false|
|price|integer|null:false|
|fee|integer|null:false|
|profit|integer|null:false|
|buyer_id|integer||
|category_id|integer|null:false  foreign_key: true|
|brand_id|integer|foreign_key: true|
|user_id|integer|null:false  foreign_key: true|
|shipping_id|integer|null:false  foreign_key: true|

## アソシエーション
- belongs_to: user
- belongs_to: category
- belongs_to: brand
- belongs_to: shipping
- has_many: images dependent: :destroy
- has_many: comments dependent: :destroy


## shippingsテーブル
|Column|Type|Options|
|------|----|-------|
|burden|integer|null:false|
|type|integer|null:false|
|area|integer|null:false|
|day|integer|null:false|

## アソシエーション
- has_many: items


## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null:false|
|item_id|integer|null:false  foreign_key: true|

## アソシエーション
- belongs_to: item


## categories
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|ancestry|string||

## アソシエーション
- has_many: items


## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

## アソシエーション
- has_many: items



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...