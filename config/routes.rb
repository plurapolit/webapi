# frozen_string_literal: true

Rails.application.routes.draw do
  get '/healthcheck', to: 'pages#healthcheck'
  devise_for :admins
  authenticate :admin do
    root to: 'pages#home'
    resources :users, except: [:show]
    resources :panels, except: [:show]
    resources :categories, except: [:show]
    resources :organisations, except: [:show]
    resources :feedbacks, only: :index
    resources :statements, except: [:show] do
      member do
        patch :accept
        patch :reject
      end
    end
    resources :comments, except: [:show] do
      member do
        patch :accept
        patch :reject
      end
    end
  end

  namespace 'api', defaults: { format: :json } do
    resources :statements, only: %i[create destroy] do
      resources :comments, only: %i[create destroy index]
      delete 'likes', to: 'likes#destroy'
      resources :likes, only: :create
    end
    resources :panels, only: %i[show index]
    resources :slugs, only: :index
    resources :feedbacks, only: :create
    resources :user_audio_trackings, only: :create
    get 'authenticate', to: 'pages#authenticate'
  end

  devise_for :users, module: 'api/users',
                     path: '/api/users',
                     defaults: { format: :json }
end
