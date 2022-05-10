# rubocop:disable Layout/LineLength

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'register' }

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :likes, only: %i[create]
      resources :comments, only: %i[create]
    end
  end

  root 'users#index'
end
