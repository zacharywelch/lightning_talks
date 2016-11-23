Rails.application.routes.draw do

  namespace :admin do
    root 'application#index'
    resources :users
    resources :meetings do
      resources :talks, only: [:new, :create, :edit, :update]
    end
  end

  resources :meetings do
    resources :talks, only: [:new, :create]
  end
  
  resources :talks, only: [:show, :edit, :update, :destroy] do
    resource :comments, only: [:create]
  end

  resources :users, only: [:index, :show] do
    resources :talks, only: [:index]
    resources :favorites, only: [:index]
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :favorites

  get  'signin' => 'sessions#new'
  post 'saml/consume' => 'sessions#create'
  post 'sessions/create' => 'sessions#create'

  root 'meetings#index'
end
