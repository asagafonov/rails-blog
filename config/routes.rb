Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users, path: 'users', path_names: { sign_in: 'sign_in', sign_out: 'sign_out', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
