class Users::OrdersController < Users::ApplicationController
  def create
    order = Order.build_from_cart(current_user, current_cart)
    order.total_amount = current_cart.payment_total
    order.delivery_date = params[:delivery_date]
    order.delivery_time = params[:delivery_time]
    if order.save
      current_cart.cart_items.each(&:destroy!)
      redirect_to root_path, notice: t('orders.order_items.created')
    else
      redirect_to cart_path, alert: t('orders.create_error')
    end
  end

  def index
    @orders = Order.preload(:user).default_order.page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end
end
