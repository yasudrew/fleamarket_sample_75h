Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/registration', to: 'users#new'
  get '/mypage', to: 'users#show'
  get 'card/new'

  devise_for :users

  root 'items#index'
  
end