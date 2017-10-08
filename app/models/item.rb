class Item < ApplicationRecord
  belongs_to :product

  before_save :calculate_total_wieght

  validates :quantity, presence: true
  validates_numericality_of :quantity

  self.per_page = 10

  def add(amount)
    self.quantity = self.quantity.to_i + amount.to_i
  end

  private

  def calculate_total_wieght
    self.total_wieght = quantity * product.wieght
  end
end
