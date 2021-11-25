require 'sidekiq/web'

Rails.application.routes.draw do
  
  
  
  # get 'bid_offers/new'
  # get 'bid_offers/create'
  # get 'bid_offers/edit'
  # get 'bid_offers/update'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  if Rails.env.development?
    mount Sidekiq::Web => '/sidekiq'
  else
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end
  end
  #resources :users do
  resources :products, only: [:index] do
    resources :bids, only: [:index, :show, :new, :create, :destroy] do
        resources :bid_offers, only: [:new,:create,:edit,:update]
    end
  end

  # resources :bids, only: [:index,:destroy]
end
