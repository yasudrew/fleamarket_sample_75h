class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :brand
  belongs_to :shipping
  has_many :images, dependent: :destroy
  has_many :favorites
  has_many :users, through: :favorites

  accepts_nested_attributes_for :category
  # has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :shipping
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :images


  validates :name,length:{maximum:20}
  validates :description, length:{maximum:1000}
  validates :price,numericality:{greater_than_or_equal_to: 300} 

  with_options presence: true do
    validates :name
    validates :description
    validates :status
    validates :price
    validates :fee
    validates :profit
    validates :user_id
    # validates :category_id 未解決問題　保存できなくなる
    # validates :shipping_id　未解決問題　保存できなくなる
    validates :images

  end

  def self.search(search)
    return Item.all unless search
    Item.where('text LIKE(?)', "%#{search}%")
  end

  enum status: {
    新品未使用:1,未使用に近い:2,目立った傷や汚れなし:3,やや傷や汚れあり:4,傷や汚れあり:5,全体的に状態が悪い:6
  }
end