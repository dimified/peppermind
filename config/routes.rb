Peppermind::Application.routes.draw do

  # The route to the root
  authenticated :user do
  	root to: "users#show"
  end
  root :to => 'home#index'

  # user authentication
  devise_for :users
  match '/auth/:socialprovider/callback' => 'socialproviders#create'
  resources :socialproviders, :only => [:index, :create, :destroy]

  resources :users
  resources :ideas
  resources :idea_steps
end
