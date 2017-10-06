class Product < ApplicationRecord
  belongs_to :hangar
  has_many :items

  validates :name, presence: true
  validates :wieght, presence: true

  validates_numericality_of :wieght
  validates_uniqueness_of :name

  self.per_page = 5
end
