require 'sidekiq/web'

Rails.application.routes.draw do
  mount Notifications::Engine => "/notifications"
  devise_for :users 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  else
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
  root to: "home#index"

  get 'products', to: 'products#index'
  get 'products/:id', to: 'products#show', as: 'product'
  get 'products/categories/:id', to: 'categories#show', as: 'category'
  
  resources :users do
    resources :orders, only: [:index]
    resources :carts, only: [:index, :destroy] do
      resources :orders, only: [:create, :destroy]
    end
    resources :stores do
      resources :orders, only: [:index]
      resources :chats do
        resources :messages
      end
      resources :products do
        resources :stocks
        resources :line_items, only: [:create]
        resources :comments
      end
    end
  end

  post 'line_items/:id/add' => "line_items#add_quantity", as: "line_item_add"
  post 'line_items/:id/reduce' => "line_items#reduce_quantity", as: "line_item_reduce"
  delete 'line_items/:id' => "line_items#destroy", as: "line_item_delete"

end
