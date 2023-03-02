Rails.application.routes.draw do
  resources :permissions_roles
  resources :permissions
  resources :user_roles
  resources :roles
  resources :contacts
  resources :suburbs
  resources :cities
  resources :regions
  devise_for :users
  resources :users

  root "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
