class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
end
