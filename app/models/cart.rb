class Cart < ApplicationRecord
  TAX_RATE = 0.1
  BASE_SHIPPING_FEE = 600

  belongs_to :user

  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def subtotal_price
    cart_items.sum { |item| item.product.price * item.quantity }
  end

  def delivery_fee
    case subtotal_price
    when 0...10_000 then 300
    when 10_000...30_000 then 400
    when 30_000...100_000 then 600
    else 1_000
    end
  end

  def shipping_fee
    shipping_units = (cart_items.sum(:quantity) / 5)
    shipping_units * BASE_SHIPPING_FEE
  end

  def total_price
    subtotal_price + shipping_fee + delivery_fee
  end

  def tax_amount
    (total_price * TAX_RATE).round
  end

  def payment_total
    total_price + tax_amount
  end
end
