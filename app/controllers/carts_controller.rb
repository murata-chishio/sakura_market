class CartsController < ApplicationController
  before_action :set_cart, :set_delivery_date

  def show
  end

  private

  def set_cart
    @cart = current_cart
  end

  def set_delivery_date
    @min_delivery_date = Order.calculate_business_days(3)
    @max_delivery_date = Order.calculate_business_days(14)
  end
end
