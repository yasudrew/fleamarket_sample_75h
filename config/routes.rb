Rails.application.routes.draw do
  get 'users/show'
  get 'user/show'
  devise_for :users
  root 'items#index'
  
end
