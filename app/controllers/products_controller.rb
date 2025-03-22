class ProductsController < ApplicationController
  def index
    @products = Product.default_order
  end
end
