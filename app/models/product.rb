class Product < ApplicationRecord
  belongs_to :hangar
  has_many :stock_products

  validates :name, presence: true
  validates :wieght, presence: true

  validates_numericality_of :wieght
end
