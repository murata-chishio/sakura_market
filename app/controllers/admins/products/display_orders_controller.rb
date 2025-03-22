class Admins::Products::DisplayOrdersController < Admins::ApplicationController
  before_action :set_product

  def update
    @product.insert_at(params[:display_order].to_i)
  end

  def set_product
    @product = Product.find(params.expect(:product_id))
  end
end
