class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product_id, uniqueness: { scope: :cart_id }
  scope :default_order, -> { order(:created_at, :id) }
end
