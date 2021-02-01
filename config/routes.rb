Rails.application.routes.draw do

  # As 2 linhas abaixo são iguais
  # Get '/', to: 'home#index'
  root 'home#index'
  
  # Home Controller , Ação Index

  resources :promotions, only: [:index, :show, :create, :new, :edit, :update, :destroy]
  resources :product_categories, only: %i[ index new create show edit update ]
end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html