Rails.application.routes.draw do

  devise_for :users
  root 'places#index'
  
  resources :places do
    resources :comments, only: :create
    resources :photos, only: :create
  end
  
  resources :buckets, only: [:create] do
    collection do
      get 'visited'
    end
  end
  
  get 'bucketlist', to: 'buckets#index'
  
end
