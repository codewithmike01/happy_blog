Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :likes, only: %i[new create]
      resources :comments, only: %i[new create]
    end
  end
end
