class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2], password_length: 7..128
  validates :name, presence: true, uniqueness: true

  def self.form_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.where(email: auth.info.email).first_or_initialize(
      name: auth.info.name,
      email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
  has_one :profile, dependent: :destroy
  has_many :cards
  has_many :sns_credentials
  has_many :comments
  has_many :favorites
  has_many :items, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  
end
