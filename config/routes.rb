Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # Get '/', to: 'home#index'
  # Linha abaixo é igual
  root 'home#index'
  # Home Controller , Ação Index
  resources :promotions, only: [:index, :show, :create, :new, :edit, :update]
end
