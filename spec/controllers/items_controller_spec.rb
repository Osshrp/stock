require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item) { create(:item) }
  describe 'GET #index' do
    let(:items) { create_list(:item, 2) }

    context 'guest tries to view items' do
      before { get :index }
      it 'does not populate an array of all items' do
        expect(assigns(:items)).to_not match_array(items)
      end
      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'authenticated user tries to view items' do
      sign_in_user
      before { get :index }
      it 'populates an array of all items' do
        expect(assigns(:items)).to match_array(items)
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do

    context 'guest tries to view item' do
      before { get :show, params: { id: item } }

      it 'does not assign requested item to @item' do
        expect(assigns(:item)).to_not eq item
      end

      it 'redirects to new session view' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'authenticated user tries to view item' do
      sign_in_user

      before { get :show, params: { id: item } }

      it 'assigns requested item to @item' do
        expect(assigns(:item)).to eq item
      end

      it 'renders show view' do
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    context 'authenticated user tries to create item' do
      sign_in_user
      before { get :new }
      it 'assigns a new Item to @item' do
        expect(assigns(:item)).to be_a_new(Item)
      end

      it 'renders new view' do
        expect(response).to render_template :new
      end
    end

    context 'guest tries to create item' do
      before { get :new }
      it 'assigns a new Item to @item' do
        expect(assigns(:item)).to_not be_a_new(Item)
      end

      it 'renders new view' do
        expect(response).to_not render_template :new
      end
    end
  end

  describe 'POST #create' do
    let(:product) { create(:product) }
    context 'authenticated user tries to create item' do
      sign_in_user
      context 'with valid attributes' do

        it 'creates a new Item' do
          item
          expect { post :create, params: { item: attributes_for(:item)
            .merge(product_id: product) } }
            .to change(Item, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { item: attributes_for(:item)
            .merge(product_id: product) }
          expect(response).to redirect_to item_path(assigns(:item))
        end
      end

      context 'if item exists' do
        let!(:item) { create(:item, quantity: 5, product: product) }
        it 'does not create new one' do
          expect { post :create, params: { item: { quantity: '5' }
            .merge(product_id: product) } }
            .to_not change(Item, :count)
        end

        it 'increases quantity' do
          post :create, params: { item: { quantity: '5' }.merge(product_id: product) }
          expect(Item.last.quantity).to eq(10)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the item' do
          expect { post :create, params: { item: attributes_for(:invalid_item) } }
            .to_not change(Item, :count)
        end

        it 're-renders new view' do
          post :create, params: { item: attributes_for(:invalid_item) }
          expect(response).to render_template :new
        end
      end
    end

    context 'unauthenticated user tries to create item' do
      it 'does not create a new Item' do
        item
        expect { post :create, params: { item: attributes_for(:item)
          .merge(product_id: product) } }
          .to_not change(Item, :count)
      end

      it 'redirects to new session path' do
        post :create, params: { item: attributes_for(:item)
          .merge(product_id: product) }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end