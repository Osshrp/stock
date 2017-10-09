Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: 'products#index'

  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  resources :products

  resources :items do
    patch :deduct, on: :member
    get :subtract, on: :member
  end

  namespace :admin do
    resources :items, only: :index
    resources :users
  end
end
