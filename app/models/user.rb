class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_many :cart_items, through: :cart
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  def full_address
    return nil if [postcode, prefecture, address_city, address_street].any?(&:blank?)

    [postcode, prefecture, address_city, address_street, address_building].compact.join(' ')
  end
end
