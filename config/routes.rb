Rails.application.routes.draw do
  devise_for :users

  get '/logout', to: 'sessions#logout_page'
  get '/card_page', to: 'card#card_page'
  get '/purchase_confirmation', to: 'items#purchase_confirmation'

  resources :sessions, only: [:new, :destroy]
  resources :users, only: [:new, :show]
  resources :card, only: [:new]
  resources :items, only: [:new,:create, :show] do
    collection do
      get 'purchase_confirmation'
    end
  end

  root 'items#index'


end