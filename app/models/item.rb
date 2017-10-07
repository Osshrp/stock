class Item < ApplicationRecord
  belongs_to :product

  self.per_page = 10
end
