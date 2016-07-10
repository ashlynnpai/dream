Rails.application.routes.draw do

  devise_for :users
  root 'places#index'
  
  resources :places do
    resources :comments, only: :create
    resources :photos, only: :create
  end
  
  resources :users, only: [:show, :update]
  
  resources :buckets, only: [:update]  
  resources :completed_buckets, only: [:index]
  
  get 'bucketlist', to: 'buckets#index'
  post 'bucketlist', to: 'buckets#create'
  
end
