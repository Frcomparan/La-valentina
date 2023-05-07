# frozen_string_literal: true

Rails.application.routes.draw do
  resources :courses
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/private', to: 'pages#private', as: 'private'
  # Defines the root path route ("/")
  root 'pages#home'
end
