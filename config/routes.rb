Peppermind::Application.routes.draw do
  # root
  authenticated :user do
   root to: 'activities#index'
  end
  root :to => 'home#index'

  # users
  devise_for :users
  resources :users, except: [:new]
  match '/auth/:socialprovider/callback' => 'socialproviders#create'
  resources :socialproviders, only: [:index, :create, :destroy]

  # challenges and dashboard
  resources :challenges, :activities do
    get 'page/:page', action: :index, on: :collection, constraints: { :page => /\d/ }
  end

  resources :challenges do
    resources :inspirations
  end

  resources :idea_steps
end
