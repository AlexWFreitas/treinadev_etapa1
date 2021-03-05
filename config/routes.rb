Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :product_categories, only: %i[ index new create show edit update ] 
  
  resources :promotions, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
    member do
      post 'generate_coupons'
      post 'approve'
    end
  end

  resources :coupons, only: [] do
    post 'disable', on: :member
    post 'enable', on: :member
  end

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :coupons, only: [:show]
    end
  end
end