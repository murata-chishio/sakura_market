class CartItemsController < ApplicationController
  before_action :set_product, only: [:create]

  def create
    cart_item = current_cart.cart_items.find_or_initialize_by(product: @product)
    cart_item.quantity += params[:quantity].to_i

    cart_item.save
    redirect_to @product, notice: t('carts.cart_items.created')
  end

  def destroy
    CartItem.find(params[:id]).destroy!
    redirect_to cart_path, notice: t('carts.cart_items.deleted'), status: :see_other
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
