Peppermind::Application.routes.draw do
  # root route
  root :to => 'home#index'

  # user authentication
  devise_for :users
  match '/auth/:socialprovider/callback' => 'socialproviders#create'
  resources :socialproviders, :only => [:index, :create, :destroy]

  resources :users
end
