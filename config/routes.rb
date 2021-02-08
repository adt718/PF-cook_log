Rails.application.routes.draw do
 get 'sessions/new'
 get :signup,       to: 'users#new'
 root 'static_pages#home'
 get :about,        to: 'static_pages#about'
 get :use_of_terms, to: 'static_pages#terms'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 get     :login,     to: 'sessions#new'
 post    :login,     to: 'sessions#create'
 delete  :logout,    to: 'sessions#destroy'
 resources :users
end
