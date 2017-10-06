require 'rails_helper'

feature 'User deletes product', %q{
  User can delete product
} do

  given(:user) { create(:user) }
  given(:product) { create(:product) }

  scenario 'Authenticated user tries to delete his product' do
    sign_in(user)

    visit product_path(product)
    click_on 'Удалить'

    expect(page).to have_no_content product.name
  end

  scenario 'Unauthenticated user tries to delete product' do
    visit product_path(product)

    expect(page).to have_no_content 'Удалить'
  end
end
