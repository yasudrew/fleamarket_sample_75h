Rails.application.routes.draw do
  devise_for :users

  get '/logout', to: 'sessions#logout_page'

  resources :users, only: [:new, :show]
  resources :cards, only: [:new, :create, :show] do
    collection do
      delete :delete
    end
  end
  resources :items, except: [:index, :update] do
    member do
      get :purchase_confirmation
    end
  end

  root 'items#index'


end