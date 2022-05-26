Rails.application.routes.draw do
<<<<<<< HEAD
  resources :reports, only: :index
=======
  resources :reports, only: [:index, :update]
>>>>>>> 40abd013da30832fa830c80edc563504dfc3fb9d
  resources :items, only: [:index, :edit, :update]
  resources :stocks, only: [:edit, :update]
  # 出庫
  # get 'items/out_stock', to: 'items#out_stock'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
