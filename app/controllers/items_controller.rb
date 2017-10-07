class ItemsController < ApplicationController
  def index
    @index = 0
    @items = Item.page(params[:page])
  end
end
