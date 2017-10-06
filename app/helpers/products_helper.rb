module ProductsHelper
  def product_index
    @index += 1
    Product.per_page * (params[:page].to_i - 1) + @index
  end
end
