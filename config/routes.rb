Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'comments/new'
  get 'comments/create'
  get 'comments/edit'
  get 'comments/update'
  get 'comments/destroy'
  root 'posts#index'
  devise_for :users, path_names: { sign_in: 'sign_in', sign_out: 'sign_out', sign_up: 'sign_up' }

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'users/sign_out', to: 'devise/sessions#destroy'
    get 'sign_up', to: 'devise/registrations#new'
  end

  resources :posts do
    scope module: :posts, shallow: true do
      resources :comments
    end
  end
end
