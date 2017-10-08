class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :edit, :destroy, :deduct, :subtract]
  before_action :set_product, only: [:show, :new]
  def index
    @index = 0
    @items = Item.page(params[:page]).distinct
  end

  def show
    @product = @item.product
    respond_with(@item)
  end

  def new
    @item = Item.new
    respond_with @item
  end

  def create
    @item = Item.find_or_initialize_by(product_id: items_params[:product_id])
    @item.add(items_params[:quantity])
    @item.save
    respond_with(@item)
  end

  def subtract
  end

  def deduct
    @item.subtract(items_params[:quantity])
    @item.save
    respond_with(@item, action: :subtract)
  end

  private

  def items_params
    params.require(:item).permit(:quantity, :product_id)
  end

  def set_product
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
