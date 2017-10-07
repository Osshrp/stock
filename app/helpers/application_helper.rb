module ApplicationHelper
  def set_index(resource)
    @index += 1
    resource.class.per_page * (params[:page].to_i - 1) + @index
  end
end
