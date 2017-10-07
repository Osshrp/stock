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

      it 'does not assign requested product to @item' do
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
end
