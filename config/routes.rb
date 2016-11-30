Rails.application.routes.draw do

  root 'welcome#index'

  namespace :admin do
    root 'application#index'
    resources :meetings do
      resources :talks, only: [:new, :create, :edit, :update]
    end
  end

  resources :meetings do
    resources :talks, only: [:new, :create]
  end

  resources :talks, only: [:show, :edit, :update, :destroy, :new] do
    resource :comments, only: [:create]
    collection do
      get :upcoming, :recent, :popular
    end
  end

  resources :users do
    resources :talks, only: [:index]
    resources :favorites, only: [:index]
    member do
      get :following, :followers
    end
  end

  get :speakers, to: 'users#speakers'

  resources :relationships, only: [:create, :destroy]
  resources :favorites

  get  'signin' => 'sessions#new'
  post 'saml/consume' => 'sessions#create'
  post 'sessions/create' => 'sessions#create'
end
