# rubocop:disable Layout/LineLength

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'register' }

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create destroy edit] do
      resources :likes, only: %i[create]
      resources :comments, only: %i[create destroy]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
        resources :users, only: %i[index show] do
        resources :posts, only: %i[index show] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end

  post 'api/v1/register', to: 'api/v1/registrations#create', defaults: { format: :json }
  get 'api/v1/login', to: 'api/v1/sessions#create', defaults: { format: :json }

  root 'homes#index'
end
