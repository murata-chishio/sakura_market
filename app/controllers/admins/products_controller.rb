class Admins::ProductsController < ApplicationController
  before_action :set_admins_product, only: %i[show edit update destroy]

  # GET /admins/products or /admins/products.json
  def index
    @admins_products = Admins::Product.all
  end

  # GET /admins/products/1 or /admins/products/1.json
  def show
  end

  # GET /admins/products/new
  def new
    @admins_product = Admins::Product.new
  end

  # GET /admins/products/1/edit
  def edit
  end

  # POST /admins/products or /admins/products.json
  def create
    @admins_product = Admins::Product.new(admins_product_params)

    respond_to do |format|
      if @admins_product.save
        format.html { redirect_to @admins_product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @admins_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admins_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/products/1 or /admins/products/1.json
  def update
    respond_to do |format|
      if @admins_product.update(admins_product_params)
        format.html { redirect_to @admins_product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @admins_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admins_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/products/1 or /admins/products/1.json
  def destroy
    @admins_product.destroy!

    respond_to do |format|
      format.html { redirect_to admins_products_path, status: :see_other, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admins_product
    @admins_product = Admins::Product.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def admins_product_params
    params.fetch(:admins_product, {})
  end
end
