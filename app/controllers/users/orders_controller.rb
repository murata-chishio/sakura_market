class Users::OrdersController < Users::ApplicationController
  def create
    order = Order.build_from_cart(current_user, current_cart)
    order.save
    current_cart.cart_items.each(&:destroy!)
    redirect_to root_path, notice: t('orders.order_items.created')
  end
end
