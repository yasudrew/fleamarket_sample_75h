class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 7..128
  validates :name, presence: true, uniqueness: true

  has_many :cards
  has_many :favorites
  has_many :items, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
end
