class Admin::ItemsController < ApplicationController
  def index
    @index = 0
    @transactions = Transaction.all
    @items = Item.paginate(page: params[:page]).distinct
  end
end
