Rails.application.routes.draw do
  resources :items, only: [:index, :update]
  # 出庫
  resources :items do
    member do
      get 'out_stock' 
    end
  end
  # get 'items/out_stock', to: 'items#out_stock'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
