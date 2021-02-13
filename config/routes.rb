Rails.application.routes.draw do
 get 'lists/index'
 resources :notifications, only: :index
 resources :logs, only: [:create, :destroy]
 get 'sessions/new'
 get :signup,       to: 'users#new'
 root 'static_pages#home'
 get :about,        to: 'static_pages#about'
 get :use_of_terms, to: 'static_pages#terms'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get :favorites, to: 'favorites#index'
 post   "favorites/:dish_id/create"  => "favorites#create"
 delete "favorites/:dish_id/destroy" => "favorites#destroy"
 get     :login,     to: 'sessions#new'
 post    :login,     to: 'sessions#create'
 delete  :logout,    to: 'sessions#destroy'
 resources :users
 resources :dishes
 resources :relationships, only: [:create, :destroy]
 resources :comments, only: [:create, :destroy]
  resources :users do
    member do
     get :following, :followers
     end
    end
end
