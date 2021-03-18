Rails.application.routes.draw do
  get :lists, to: 'lists#index'
  post   "lists/:dish_id/create"  => "lists#create"
  delete "lists/:list_id/destroy" => "lists#destroy"
  post 'lists/:dish_id/create' => 'lists#create'
  resources :notifications, only: :index
  get 'destroy_all_users_notifications' => 'notifications#destroy_all'
  resources :logs, only: [:create, :destroy]
  get 'sessions/new'
  get :signup, to: 'users#new'
  root 'static_pages#home'
  get :about,        to: 'static_pages#about'
  get :use_of_terms, to: 'static_pages#terms'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :favorites
  # get :favorites, to: 'favorites#index'
  # get :favorites, to: 'favorites#index'
  get     :login,     to: 'sessions#new'
  post    :login,     to: 'sessions#create'
  delete  :logout,    to: 'sessions#destroy'
  resources :users
  resources :dishes
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  # resources :favorites, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
end
