class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page])

    respond_with @products
  end
end
