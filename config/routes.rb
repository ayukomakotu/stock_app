Rails.application.routes.draw do
  root 'sessions#new'
  resources :reports, only: [:index, :edit, :update, :destroy]
  resources :items
  resources :stocks, only: [:edit, :update]
  # 出庫
  # get 'items/out_stock', to: 'items#out_stock'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
