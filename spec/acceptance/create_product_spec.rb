require 'rails_helper'

feature 'Create product', %q{
  as an authenticated user
  I need to be able to create products
} do

  given(:user) { create(:user) }
  given!(:hangar) { create(:hangar) }

  scenario 'Authenticated user creates product' do
    sign_in(user)

    click_new_product_link
    fill_in 'product_name', with: 'Product name'
    fill_in 'product_wieght', with: '1.11'
    select hangar.number, from: 'product_hangar_id'
    click_on 'Сохранить'

    # expect(page).to have_content 'Your product successfully created'
    expect(page).to have_content 'Product name'
    expect(page).to have_content '1.11'
    expect(page).to have_content 'Ангар: 1'
  end

  scenario 'Authenticated user tries to create product with blank fields' do
    sign_in(user)

    click_new_product_link
    click_on 'Сохранить'

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Wieght can't be blank"
    expect(page).to have_content "Hangar must exist"
  end

  scenario 'Unauthenticated user tries to create product' do
    visit products_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  private

  def click_new_product_link
    visit products_path
    click_on 'Добавить номенклатуру'
  end
end
