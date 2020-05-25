Rails.application.routes.draw do
  devise_for :users

  get '/logout', to: 'sessions#logout_page'
  get '/card_page', to: 'card#card_page'

  resources :sessions, only: [:new, :destroy]
  resources :users, only: [:new, :show]
  resources :card, only: [:new]

  root 'items#index'
  

end