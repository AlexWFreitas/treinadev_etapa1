Rails.application.routes.draw do

  # As 2 linhas abaixo são iguais
  # get '/', to: 'home#index'
  root 'home#index'
  
  # Home Controller , Ação Index

  resources :promotions, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
    post 'generate_coupons', on: :member
  end

  resources :coupons, only: [] do
    post 'disable', on: :member
  end

  resources :product_categories, only: %i[ index new create show edit update ] 
end