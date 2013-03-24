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
  resources :idea_steps

  resources :ideas do
    get ':page', :action => :index, :on => :collection, :constraints => { :page => /\d/ }
  end
end
