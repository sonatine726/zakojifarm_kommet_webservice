Rails.application.routes.draw do
  config = Rails.application.config.kommet

  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'
  resources :posts, only: [:create]

  constraints host: config[:customer][:host] do
    namespace :customer , path: config[:customer][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, only: [ :index, :show, :edit, :update ] do
        patch :confirm
      end
      resources :programs, only: [ :index, :show ] do
        resources :entries, only: [ :create] do
          patch :cancel, on: :member
        end
      end
      resources :messages, only: [ :new, :create ] do
        post :confirm, on: :collection
      end
    end
  end

  constraints host: config[:staff][:host] do
    namespace :staff , path: config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, only: [ :show, :edit, :update ]
      resource :password, only: [ :show, :edit, :update ]
      resources :customers
      resources :programs do
        patch :entries, on: :member
      end
      resources :messages, only: [] do
        get :count, on: :collection
      end
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path], module: 'staff/admin' do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resources :staff_members do
        resources :staff_events, only: [ :index ]
      end
      resources :staff_events, only: [ :index ]
      resources :allowed_sources, only: [ :index, :create ] do
        delete :delete, on: :collection
      end
    end
  end

  get '*anything' => 'errors#routing_error'
end

