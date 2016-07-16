Rails.application.routes.draw do

  devise_for :users
  root 'places#index'
  
  resources :places do
    resources :comments, only: :create
    resources :photos, only: :create
    collection do
      get :search, to: "places#search"
    end
  end
  
  resources :users, only: [:show, :update]
  resource :dashboard, only: [:show]
  
  namespace :admin do
    resources :places, only: [:destroy]
  end
  
  resources :buckets, only: [:update, :destroy]  
  resources :completed_buckets, only: [:index, :destroy]
  
  resources :photos, only: [:show, :destroy]
  
 
  
  get 'bucketlist', to: 'buckets#index'
  post 'bucketlist', to: 'buckets#create'
  
end
