require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }
  describe 'GET #index' do
    let(:products) { create_list(:product, 2) }

    context 'guest tries to view product' do
      before { get :index }
      it 'does not populate an array of all products' do
        expect(assigns(:products)).to_not match_array(products)
      end
      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'authenticated user tries to view product' do
      sign_in_user
      before { get :index }
      it 'populates an array of all products' do
        expect(assigns(:products)).to match_array(products)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  # describe 'GET #show' do
  #   before { get :show, params: { id: product } }
  #
  #   it 'assigns requested product to @product' do
  #     expect(assigns(:product)).to eq product
  #   end
  #
  #   it 'renders show view' do
  #     expect(response).to render_template :show
  #   end
  # end

  # describe 'GET #new' do
  #   sign_in_user
  #   before { get :new }
  #   it 'assigns a new Product to @product' do
  #     expect(assigns(:product)).to be_a_new(Product)
  #   end
  #
  #   it 'renders new view' do
  #     expect(response).to render_template :new
  #   end
  # end
  #
  # describe 'POST #create' do
  #   sign_in_user
  #   context 'with valid attributes' do
  #
  #     it 'creates a new Product' do
  #       expect { post :create, params: { product: attributes_for(:product) } }
  #         .to change(@user.products, :count).by(1)
  #     end
  #
  #     it 'redirects to show view' do
  #       post :create, params: { product: attributes_for(:product) }
  #       expect(response).to redirect_to product_path(assigns(:product))
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     it 'does not save the product' do
  #       expect { post :create, params: { product: attributes_for(:invalid_product) } }
  #         .to_not change(Product, :count)
  #     end
  #
  #     it 're-renders new view' do
  #       post :create, params: { product: attributes_for(:invalid_product) }
  #       expect(response).to render_template :new
  #     end
  #   end
  # end

  # describe 'PATCH #update' do
  #   sign_in_user
  #   let!(:users_product) { create(:product, user: @user) }
  #
  #   context 'with valid attributes' do
  #     it 'assigns the requested product to @product' do
  #       patch :update, params: { id: users_product,
  #         product: attributes_for(:product) }, format: :js
  #       expect(assigns(:product)).to eq users_product
  #     end
  #
  #     it 'change product attributes' do
  #       patch :update, params: { id: users_product,
  #         product: { title: 'new_title', body: 'new_body' } }, format: :js
  #       users_product.reload
  #       expect(users_product.title).to eq 'new_title'
  #       expect(users_product.body).to eq 'new_body'
  #     end
  #
  #     it 'redirects to updated @product' do
  #       patch :update, params: { id: users_product,
  #         product: attributes_for(:product) }, format: :js
  #       expect(response).to render_template :update
  #     end
  #   end
  #
  #   context 'with invalid attributes' do
  #     let(:title) { users_product.title }
  #     let(:body) { users_product.body }
  #     before do
  #       patch :update, params: { id: users_product,
  #         product: { title: 'new_title', body: nil } }, format: :js
  #     end
  #     it 'does not change @product attributes' do
  #       users_product.reload
  #       expect(users_product.title).to eq title
  #       expect(users_product.body).to eq body
  #     end
  #
  #     it 're-renders edit view' do
  #       expect(response).to render_template :update
  #     end
  #   end
  #
  #   context 'user tries to update product that does not belong to him' do
  #     let(:title) { product.title }
  #     let(:body) { product.body }
  #     before do
  #       patch :update, params: { id: product,
  #         product: { title: 'new_title', body: 'new_body' } }, format: :js
  #     end
  #     it 'does not update product attributes' do
  #       product.reload
  #       expect(product.title).to eq title
  #       expect(product.body).to eq body
  #     end
  #
  #     it 'returns 403 status' do
  #       expect(response).to have_http_status(403)
  #     end
  #   end
  # end
  #
  # describe 'DELETE #destroy' do
  #   sign_in_user
  #   let!(:users_product) { create(:product, user: @user) }
  #   before { product }
  #
  #   context 'author tries to delete product' do
  #     it 'deletes product' do
  #       expect { delete :destroy, params: { id: users_product } }
  #         .to change(Product, :count).by(-1)
  #     end
  #
  #     it 'redirects to index view' do
  #       delete :destroy, params: { id: users_product }
  #       expect(response).to redirect_to products_path
  #     end
  #   end
  #
  #   context 'user tries to delete product that does not belongs to him' do
  #     it 'does not deletes product' do
  #       expect { delete :destroy, params: { id: product } }
  #         .to_not change(Product, :count)
  #     end
  #
  #     it 'redirects to products index view' do
  #       delete :destroy, params: { id: product }
  #       expect(response).to redirect_to products_path
  #     end
  #   end
end
