class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page])

    respond_with(@products)
  end

  def show
    @product = Product.find(params[:id])
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def create
    @product = Product.create(product_params)
    respond_with(@product)
  end

  private

  def product_params
    params.require(:product).permit(:name, :wieght, :hangar_id)
  end

  def set_product
  end
end
