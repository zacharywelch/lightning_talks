Rails.application.routes.draw do
  root 'welcome#index'

  resources :meetings do
    resources :talks, only: [:new, :create]
  end

  resources :talks, only: [:show, :edit, :update, :destroy, :new] do
    resource :comments, only: [:create]
    get :upcoming, :recent, :popular, on: :collection
  end

  resources :users do
    resources :talks, only: [:index]
    resources :favorites, only: [:index]
    get :following, :followers, on: :member
    get :speakers, on: :collection
  end

  resources :relationships, only: [:create, :destroy]
  resources :favorites
  resources :tags, only: [:index, :show]
  resources :categories, only: [:index, :show]

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'signout', to: 'sessions#destroy', as: 'signout'
end
