Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
      member do 
        get :followers, :followeds
      end
    end
  resources :books do
  resource :favorite, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  root 'homes#top'
  get 'home/about' => 'homes#about'
  end