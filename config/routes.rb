Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'top#index'
  get 'users/search' => 'users#search', as: "users_search"
  resources :users, only: [:index, :show, :edit, :update]
  resources :friend_requests
  resources :friendships, only: [:index, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :posters, only: [:show, :create]
  get 'events/:id/invitation' => 'invitations#index', as: "invitations"
  post 'events/:id/invitation/create' => 'invitations#create', as: "create_invitation"
  get 'events/:id/invitation/new' => 'invitations#new', as: "new_invitation"
  patch 'events/:id/invitation/accept' => 'invitations#accept', as: "accept_invitation"
  patch 'events/:id/invitation/decline' => 'invitations#decline', as: "decline_invitation"
  delete 'events/:id/invitation/destroy' => 'invitations#destroy', as: "destroy_invitation"
  resources :events do
    member do
      post 'add_watches' => "user_watches#add"
      delete 'remove_watches' => "user_watches#remove"
    end
  end

end
