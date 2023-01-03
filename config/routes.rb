# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /ru|en/ do
    root 'posts#index'
    devise_for :users, path_names: { sign_in: 'sign_in', sign_out: 'sign_out', sign_up: 'sign_up' }

    devise_scope :user do
      get 'sign_in', to: 'devise/sessions#new'
      get 'users/sign_out', to: 'devise/sessions#destroy'
      get 'sign_up', to: 'devise/registrations#new'
    end

    resources :posts do
      scope module: :posts, shallow: true do
        resources :comments, only: %i[show edit update destroy]
      end

      scope module: :posts do
        resources :comments, only: %i[index new create]
        resources :likes, only: %i[create destroy]
      end
    end
  end
end
