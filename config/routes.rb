# rubocop:disable Layout/LineLength

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'register' }

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy edit] do
      resources :likes, only: %i[create]
      resources :comments, only: %i[create destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'register' }, controllers: { registrations: 'registrations', sessions: 'sessions' }
      resources :users, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end

  # get 'api/v1/users/register', to: 'api/v1/registrations#new'
  # get 'api/v1/users/login', to: 'api/v1/sessions#new
  root 'homes#index'
end
