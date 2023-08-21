Rails.application.routes.draw do
  get 'users/show'
  get 'comments/index'
  devise_for :users
  root 'prototypes#index'
  resources :users, only: :show
  resources :prototypes do
    resources :comments, only: [:index, :create]
  end
end
