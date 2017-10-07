require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should belong_to(:product) }

  let(:item) { create(:item, quantity: 3) }

  describe '#calculate_total_wieght' do
    it 'should calculate total_wieght' do
      expect(item.total_wieght).to eq(item.product.wieght * 3)
    end
  end
end
