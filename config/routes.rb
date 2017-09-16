Rails.application.routes.draw do
  root 'welcome#index'

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

  resources :tags, only: [:index, :show]

  resources :categories, only: [:index, :show]

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
end
