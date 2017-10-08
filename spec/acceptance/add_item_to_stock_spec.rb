require 'rails_helper'

feature 'Create item', %q{
  as an authenticated user
  I need to be able to create itmes in stock
} do

  given(:user) { create(:user) }
  given!(:product) { create(:product) }

  describe 'Authenticated user creates item' do

    scenario 'it creates new item if item does not exists on the stock' do
      sign_in(user)
      click_new_item_link
      select product.name, from: 'item_product_id'
      fill_in 'item_quantity', with: '10'
      click_on 'Сохранить'

      expect(page).to have_content product.name
      expect(page).to have_content '10'
      expect(page).to have_content product.wieght * 10
      expect(page).to have_content product.hangar.number
    end

    describe 'if item exists' do
      given!(:item) { create(:item, product: product, quantity: '10') }

      scenario 'it does not create new one but increases quantity of item' do
        sign_in(user)

        click_new_item_link
        select product.name, from: 'item_product_id'
        fill_in 'item_quantity', with: '10'
        click_on 'Сохранить'

        expect(page).to have_content product.name
        expect(page).to have_content '20'
        expect(page).to have_content product.wieght * 20
        expect(page).to have_content product.hangar.number
      end
    end
  end

  scenario 'Authenticated user tries to create item with blank fields' do
    sign_in(user)

    click_new_item_link
    click_on 'Сохранить'

    expect(page).to have_content "Product must exist"
  end

  scenario 'Unauthenticated user tries to create item' do
    visit items_path
    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end

  private

  def click_new_item_link
    visit items_path
    click_on 'Добавить товар на склад'
  end
end
