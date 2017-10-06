require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:item) { create(:itme) }
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
end
