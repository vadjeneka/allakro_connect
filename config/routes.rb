require 'sidekiq/web'

Rails.application.routes.draw do
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get "users/signin", to: "users/sessions#new", as: :new_user_session_path
  end
  mount Notifications::Engine => "/notifications"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  else
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
  
  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show', as: 'product'
  get 'products/:id/like', to: 'products#like', as: 'like'
  # get '/stores/:store_id/products/:id', to: 'products#show', as: 'product'
  get 'products/categories/:id', to: 'categories#show', as: 'category'
  
  get 'orders', to: 'orders#index'
  
  resources :carts, only: [:index, :destroy]
  
  resources :users do
    resources :accounts do
      resources :transactions
    end
    resources :favorites
    resources :orders, only: [:index]
    resources :chats do
      resources :messages
    end
    resources :orders, only: [:index, :show, :destroy]
    resources :carts, only: [:index, :destroy] do
      resources :orders, only: [:create, :destroy]
    end
  end
  resources :stores do
    resources :orders, only: [:index, :show, :update, :destroy]
    resources :chats do
      resources :messages
    end
    resources :products do
      resources :stocks
      resources :line_items, only: [:create]
      resources :bids, except: [:edit, :update] do
        resources :offers, only: [:new, :create, :edit, :update]
      end
      resources :comments
    end
  end
  
  # get '/stores/:store_id/products/:id', to: 'products#show'
  get 'bids', to: 'bids#index'
  
  resources :line_items, only: [:create]
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  delete 'line_items/:id' => "line_items#destroy", as: "line_item_delete"
  resources :profiles, only: %i[show edit update]

  root to: "home#index"
end
