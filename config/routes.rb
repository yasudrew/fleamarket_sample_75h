Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  get '/registration', to: 'users#new'

  devise_for :users

  root 'items#index'
  
end