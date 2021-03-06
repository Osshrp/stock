require 'rails_helper'

feature 'Create product', %q{
  as an authenticated user
  I need to be able to create products
} do

  given(:admin_user) { create(:user) }
  given(:contractor_user) { create(:user) }
  given(:seller_user) { create(:user) }
  given!(:hangar) { create(:hangar) }

  describe 'Admin user' do
    before { admin_user.add_role(:admin) }
    scenario 'creates product' do
      sign_in(admin_user)

      click_new_product_link
      fill_in 'product_name', with: 'Product name'
      fill_in 'product_wieght', with: '1.11'
      select hangar.number, from: 'product_hangar_id'
      click_on 'Сохранить'

      expect(page).to have_content 'Product name'
      expect(page).to have_content '1.11'
      expect(page).to have_content 'Ангар: 1'
    end

    scenario 'tries to create product with blank fields' do
      sign_in(admin_user)

      click_new_product_link
      click_on 'Сохранить'

      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Wieght can't be blank"
      expect(page).to have_content "Hangar must exist"
    end
  end

  describe 'Contractor user' do
    before { contractor_user.add_role(:contractor) }
    scenario 'does not create product' do
      sign_in(contractor_user)

      visit products_path
      expect(page).to_not have_content 'Добавить номенклатуру'
    end
  end

  describe 'Seller user' do
    before { seller_user.add_role(:seller) }
    scenario 'does not create product' do
      sign_in(seller_user)

      visit products_path
      expect(page).to_not have_content 'Добавить номенклатуру'
    end
  end

  scenario 'Unauthenticated user tries to create product' do
    visit products_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  private

  def click_new_product_link
    visit products_path

    within '.products' do
      click_on 'Добавить номенклатуру'
    end
  end
end
