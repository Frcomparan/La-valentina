# frozen_string_literal: true

Rails.application.routes.draw do
  resources :courses do
    resources :lessons
  end
  devise_for :users

  get '/private', to: 'pages#private', as: 'private'
  # Defines the root path route ("/")
  root 'pages#home'
end
