Rails.application.routes.draw do
  devise_for :users

  root to: 'products#index'

  resources :products
  resources :items do
    patch :deduct, on: :member
    get :subtract, on: :member
  end
end
