Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'
  resources :posts, only: [:create]

  namespace :staff do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
  end

  namespace :admin, module: 'staff/admin' do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    resources :staff_members
  end

  get '*anything' => 'errors#routing_error'
end

