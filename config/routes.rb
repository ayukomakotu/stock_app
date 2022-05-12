Rails.application.routes.draw do
  resources :reports, only: :index
  resources :items, only: [:index, :edit, :update]
  resources :stocks, only: [:edit, :update]
  # 出庫
  # get 'items/out_stock', to: 'items#out_stock'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
