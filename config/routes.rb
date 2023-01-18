# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users

  resources :posts do
    scope module: :posts do
      resources :comments, only: %i[create destroy]
      resources :likes, only: %i[create destroy]
    end
  end
end
