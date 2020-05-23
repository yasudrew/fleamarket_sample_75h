Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/registration', to: 'users#new'
  get '/mypage', to: 'users#show'

  devise_for :users

  root 'items#index'
  
end