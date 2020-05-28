class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category ,optional: true
  belongs_to :brand
  belongs_to :shipping
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :shipping
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :images
end