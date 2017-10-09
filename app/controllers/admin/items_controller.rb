class Admin::ItemsController < ApplicationController

  authorize_resource

  def index
    @index = 0
    @transactions = Transaction.all
    @items = Item.paginate(page: params[:page]).distinct
  end
end
