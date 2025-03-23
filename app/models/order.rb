class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  def self.build_from_cart(user, cart)
    order = user.orders.build
    cart.cart_items.each do |cart_item|
      order.order_items.build(product_id: cart_item.product.id, quantity: cart_item.quantity)
    end
    order
  end
end
