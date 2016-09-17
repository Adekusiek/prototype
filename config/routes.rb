Rails.application.routes.draw do

  devise_for :users
  root 'top#index'
  resources :users, only: [:index, :show, :edit, :update]
  resources :friend_requests
  resources :friendships, only: [:index, :destroy]
end
