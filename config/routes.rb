Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :admin do
    root "categories#index"
    resources :categories, only: [:index, :create, :update, :destroy]
    resources :users,only: [:index, :update]
  end


  root "articles#index"
  resources :articles do
    collection do
      get :feeds
      get :sort
    end
  end

  resources :users do 
    member do
      get :articles
      get :replies
      get :collects
      get :drafts
      get :friends
    end
  end

  resources :replies, only: [:create, :destroy, :update]
  resources :categories, only: [:show]
  resources :friendships
  resources :collections, only: [:create, :destroy]
end
