Rails.application.routes.draw do
  devise_for :users

  get '/logout', to: 'sessions#logout_page'

  #resources :sessions, only: [:new, :destroy]
  resources :users, only: [:new, :show]
  resources :cards, only: [:new, :create, :show]
  resources :items, only: [:new, :show, :edit, :destroy] do
    member do
      get :purchase_confirmation
    end
  end

  root 'items#index'


end