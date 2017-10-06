class Hangar < ApplicationRecord
  has_many :products

  validates :number, presence: true
end
