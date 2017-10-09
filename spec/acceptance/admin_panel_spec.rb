require 'rails_helper'

feature 'View admin panel', %q{
  As an administator
  I need to be able view admin dashboard
} do
  given(:user) { create(:user, admin: true) }
  given(:product) { create(:product) }
  given(:item) { create(:item, product: product, quantity: 20) }

  context 'Admin' do
    scenario 'sees the dashboard' do
      sign_in(user)
      visit admin_dashboard_path

      within '.item' do
        expect(page).to have_content 'MyString'
        expect(page).to have_content '9.99'
        expect(page).to have_content '3'
        expect(page).to have_content 9.99*3
        expect(page).to have_content item.product.hangar.number
      end
    end
  end

  context 'Unauthenticated user' do
    scenario 'does not see the item' do
      visit item_path(item)

      expect(page).to_not have_content 'MyString'
      expect(page).to_not have_content '9.99'
      expect(page).to_not have_content "Ангар: #{item.product.hangar.number}"
    end
  end
end
