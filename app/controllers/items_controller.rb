class ItemsController < ApplicationController
  def index
    @index = 0
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @product = @item.product
    respond_with(@item)
  end
end
