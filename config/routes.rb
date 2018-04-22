Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "articles#index"
  resources :articles do
    collection do
      get :feeds
    end
  end

  resources :users

  resources :replies, only: [:create, :delete, :update]
end
