Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users
  root 'home#index'
  resources :posts, only: [:create]
end

