Rails.application.routes.draw do
  devise_for :users

  get '/logout', to: 'sessions#logout_page'
  get '/card_page', to: 'card#card_page'
  root 'items#index'
  resources :sessions, only: [:new, :destroy]
  resources :users, only: [:new, :show]
  resources :card, only: [:new]
end