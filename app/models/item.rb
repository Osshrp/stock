class Item < ApplicationRecord
  belongs_to :product

  before_save :calculate_total_wieght

  self.per_page = 10

  private

  def calculate_total_wieght
    self.total_wieght = quantity * product.wieght
  end
end
