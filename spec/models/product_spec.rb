require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:hangar) }
  it { should have_many(:stock_products) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :wieght }
  it { should validate_numericality_of(:wieght) }
end