class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product_id, uniqueness: { scope: :order_id }
  scope :default_order, -> { order(:created_at, :id) }
end
