class Admin::ItemsController < ApplicationController
  def index
    @index = 0
    @items = Item.paginate(page: params[:page]).distinct
  end
end
