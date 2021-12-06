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
  resources :tendances
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
    resources :comments
    resources :chats do
      resources :messages
    end
    resources :products do
      resources :stocks
      resources :line_items, only: [:create]
      resources :bids, except: [:edit] do
        resources :offers, only: [:new, :create, :edit, :update]
      end
      resources :comments
    end
  end

  #Historic of offers by user
  get 'profile/:user_id/offers' => "offers#historic", as: "user_offers_historic"
  #Details of offers by user
  get 'profile/:user_id/offers/:id' => "offers#details", as: "user_offers_offer_historic_details"
  
  # For historic of bids
  get '/stores/:store_id/bids/' => "bids#historic", as: "store_bids_historic"
  # For historic of bid details
  get '/stores/:store_id/bids/:id' => "bids#details", as: "store_bids_bid_historic_details"

  # get '/stores/:store_id/products/:id', to: 'products#show'
  get 'bids', to: 'bids#index'

  # Validate/Reject order
  put 'stores/:store_id/orders/:id/validated' => "orders#validate_order", as: "validate_order"
  put 'stores/:store_id/orders/:id/rejected' => "orders#reject_order", as: "reject_order"
  
  resources :line_items, only: [:create]
  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  delete 'line_items/:id' => "line_items#destroy", as: "line_item_delete"
  resources :profiles, only: %i[show edit update]

  root to: "home#index"
end
