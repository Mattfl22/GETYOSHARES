Rails.application.routes.draw do
  get 'carts/create'
  get 'carts/show'
  # get 'dashboard/show'
  # get 'products/show'
  # get 'products/new'
  # get 'products/edit'
  # get 'products/update'
  # get 'products/create'
  # get 'projects/index'
  # get 'projects/new'
  # get 'projects/edit'
  # get 'projects/create'
  # get 'projects/update'
  # get 'projects/show'
  devise_for :users
  root to: 'pages#home'
  resources :projects, only: [:index, :show, :edit, :new, :create, :update] do
    resources :products, only: [:show, :new, :create]
    resources :transactions, only: [:new,:show, :create]
  end
  resource :dashboard, only: [:show]
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
