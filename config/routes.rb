Rails.application.routes.draw do
  resources :users, only: [:new, :create, :index, :show]
  resources :tickets, only: [:new, :show, :create, :destroy, :index]
  # resources :sessions, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome', as: :welcome
  get 'admin-welcome', to: 'sessions#admin_welcome'
  get 'authorized', to: 'sessions#page_requires_login'
  get 'resolve', to: 'tickets#resolve'

  # resources :departments, only: [:new, :create, :index, :destroy, :show]

  get 'department-create', to: 'departments#new'
  post 'department-create', to: 'departments#create'
  get 'department-show', to: 'departments#index'
  delete 'department-delete', to: 'departments#destroy'
  get '/search' => 'departments#search'
end