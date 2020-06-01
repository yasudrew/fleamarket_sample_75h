Rails.application.routes.draw do
  devise_for :users

  get '/card_page', to: 'card#card_page'
  get '/logout', to: 'sessions#logout_page'
  get '/purchase_confirmation', to: 'items#purchase_confirmation'

  resources :users, only: [:new, :show]
  resources :profiles, only: [:new, :create] do
    collection do
      get 'step1'
      get 'step2'
    end
  end
  resources :card, only: [:new]
  resources :items, except: [:index, :update] do
    member do
      get 'purchase_confirmation'
    end
    collection do
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  root 'items#index'


end