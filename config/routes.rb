Rails.application.routes.draw do
  devise_for :users

  get '/logout', to: 'sessions#logout_page'

  resources :users, only: [:new, :show]
  
  resources :cards, only: [:new, :create, :show] do
    collection do
      delete :delete
    end
    member do
      post :purchase
      get :new_for_purchase
      post :create_for_purchase
    end
  end

  resources :profiles, only: [:new, :create] do
    collection do
      get 'step1'
      get 'step2'
    end
  end

  resources :items, except: [:index, :update] do
    member do
      get :purchase_confirmation
    end
  end

  root 'items#index'


end