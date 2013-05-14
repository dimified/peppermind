Peppermind::Application.routes.draw do
  # root
  authenticated :user do
   root to: 'activities#index'
  end
  root :to => 'home#index'

  # users
  devise_for :users
  resources :users, except: [:new]
  resources :socialproviders, only: [:index, :create, :destroy]
  match '/auth/:socialprovider/callback' => 'socialproviders#create'

  # challenges
  resources :challenges do
    get 'page/:page', action: :index, on: :collection, constraints: { :page => /\d/ }
    post 'dito', action: :dito, controller: :challenges
    resources :inspirations
  end

  # activities
  resources :activities do
    get 'page/:page', action: :index, on: :collection, constraints: { :page => /\d/ }
  end
  
  # idea steps
  resources :idea_steps

  # ditos
  resources :ditos
end
