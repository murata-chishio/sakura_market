class Admins::Products::PositionsController < Admins::ApplicationController
  before_action :set_product

  def update
    @product.insert_at(params[:position].to_i)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
