class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :delivery_date, presence: true
  validates :delivery_time, presence: true, inclusion: { in: %w[8-12 12-14 14-16 16-18 18-20 20-21] }
  validate :validate_delivery_date_within_valid_range

  def self.build_from_cart(user, cart)
    order = user.orders.build
    cart.cart_items.each do |cart_item|
      order.order_items.build(product_id: cart_item.product.id, quantity: cart_item.quantity)
    end
    order
  end

  def self.calculate_business_days(days)
    date = Time.zone.today
    business_days = 0

    while business_days < days
      date += 1.day
      next if date.saturday? || date.sunday?

      business_days += 1
    end

    date
  end

  def validate_delivery_date_within_valid_range
    min_date = self.class.calculate_business_days(3)
    max_date = self.class.calculate_business_days(14)

    unless delivery_date&.between?(min_date, max_date)
      errors.add(:delivery_date, :must_be_within_valid_range)
    end
  end
end
