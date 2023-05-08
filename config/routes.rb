# frozen_string_literal: true

Rails.application.routes.draw do
  resources :courses do
    resources :lessons
  end
  devise_for :users

  get '/private', to: 'pages#private', as: 'private'

  get 'admin/courses', to: 'courses#my_courses', as: 'admin_courses'

  # Defines the root path route ("/")
  root 'pages#home'
end
