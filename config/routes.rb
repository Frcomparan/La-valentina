# frozen_string_literal: true

Rails.application.routes.draw do
  resources :courses do
    resources :lessons
    resources :scores, only: %i[new create]
  end
  resources :comments, only: %i[create destroy]
  devise_for :users

  get '/private', to: 'pages#private', as: 'private'

  get 'admin/courses', to: 'courses#admin_courses', as: 'admin_courses'
  get 'my-courses', to: 'courses#my_courses', as: 'my_courses'

  # Cart routes
  get 'carts/:id' => "carts#show", as: "cart"
  delete 'carts/:id' => "carts#destroy", as: 'destroy_cart'

  # CartItems routes
  post 'cart_items' => "cart_items#create", as: 'add_cart_item'
  delete 'cart_items/:id' => "cart_items#destroy", as: 'delete_cart_item'

  #payment
  get 'checkout/now', to: 'checkouts#buy_now', as: 'buy_now'
  get 'checkout/cart', to: 'checkouts#buy_cart', as: 'buy_cart'
  get 'checkout/success', to: 'checkouts#success'
  get 'billing', to: 'billing#show'

  # Defines the root path route ("/")
  root 'pages#home'
end
