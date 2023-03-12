Rails.application.routes.draw do
  resources :permissions_roles
  resources :permissions
  resources :user_roles
  resources :roles
  resources :contacts
  resources :suburbs
  resources :cities do
    # get 'suburb_query', to: 'suburbs#suburbs_query'
  end
  resources :regions do
    get 'city_query', to: 'cities#city_query'
    resources :cities do
      get 'suburb_query', to: 'suburbs#suburb_query'
    end
  end
  devise_for :users
  resources :users

  get '/contacts/suburb/:suburb_id', to: 'contacts#index'

  root "contacts#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
