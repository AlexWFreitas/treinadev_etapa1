Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :product_categories, only: %i[ index new create show edit update ] 
  
  resources :promotions, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
    post 'generate_coupons', on: :member
  end

  resources :coupons, only: [] do
    post 'disable', on: :member
    post 'enable', on: :member
  end
end