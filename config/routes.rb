Peppermind::Application.routes.draw do
  # root path for authenticated users
  authenticated :user do
    root to: 'activities#index'
  end

  # root path for guest users
  devise_scope :user do
    root to: 'devise/sessions#new'
    put '/confirm' => 'confirmations#confirm'
    get '/users/edit' => 'account#edit'
  end

  # users
  devise_for :users, controllers: { confirmations: 'confirmations' }
  resources :users, except: [:new]
  get 'account/edit'
  post 'account/update'
  delete 'account/destroy'
  get 'account/edit_password'
  post 'account/update_password'
  resources :socialproviders, only: [:create, :destroy]
  match '/auth/:socialprovider/callback' => 'socialproviders#create'
  resources :after_signup, only: [:index, :create]

  # challenges
  resources :challenges, except: :destroy do
    # pagination
    get 'page/:page', action: :index, on: :collection, constraints: { page: /\d/ }
    resources :inspirations, except: [:index]
  end

  # activities
  resources :activities do
    # pagination
    get 'page/:page', action: :index, on: :collection, constraints: { page: /\d/ }
  end
  
  resources :ditos, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  # tags
  resources :tags, only: [:index, :show] do
    get ':id/page/:page', action: :show, on: :collection, constraints: { page: /\d/ }
  end

  # error page
  match '*not_found', to: 'errors#render_404'
end
