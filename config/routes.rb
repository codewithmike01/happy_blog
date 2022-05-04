Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :likes, only: %i[new create]
      resources :comments, only: %i[new create]
    end
  end
  # get 'users/:user_id/posts/:id', to: 'comments#new', as: 'new_user_comment'
  # post 'users/:user_id/posts/:id', to: 'comments#create'

  # get 'users/:user_id/posts/:id', to: 'likes#new', as: 'new_user_like'
  # post 'users/:user_id/posts/:id', to: 'likes#create'
end
