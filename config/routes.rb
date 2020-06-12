Rails.application.routes.draw do
  get 'sessions/logout_page'
  get 'session/logout_page'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }

  get '/logout', to: 'sessions#logout_page'

  resources :users, only: [:new, :show] do
    collection do
      get :my_favorites
      get :my_items
      get :my_purchased_items
    end
  end
  
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

  resources :shipping_datas, only: [:new, :create] do
    collection do
      get 'step1'
      get 'step2'
    end
  end


  resources :items, except: [:index] do
    collection do
      get :destroy_existing_image
    end
    
    member do
      get :purchase_confirmation
    end 

    collection do
      get :search_by_ransack
      get 'search'
      post :create_favorite
      post :destroy_favorite
      get 'category/get_category_children', to: 'items#get_category_children', defaults: { format: 'json' }
      get 'category/get_category_grandchildren', to: 'items#get_category_grandchildren', defaults: { format: 'json' }
    end
    resources :comments,  only: :create
  end

  root 'items#index'


end