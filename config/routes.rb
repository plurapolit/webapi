# frozen_string_literal: true

Rails.application.routes.draw do
  resources :regions
  get '/healthcheck', to: 'pages#healthcheck'
  devise_for :admins
  authenticate :admin do
    root to: 'pages#home'
    resources :users, except: [:show]
    resources :panels, except: [:show] do
      member do
        patch :deactivate
      end
    end
    resources :categories, except: [:show]
    resources :organisations, except: [:show]
    resources :feedbacks, only: :index
    resources :transcriptions, except: [:index]
    resources :statements, except: [:show] do
      member do
        patch :accept
        patch :reject
        patch :create_intro
        patch :create_transcription
      end
    end
    resources :comments, except: [:show] do
      member do
        patch :accept
        patch :reject
        patch :create_intro
      end
    end
  end

  namespace 'api', defaults: { format: :json } do
    resources :statements, only: %i[create destroy] do
      resources :comments, only: %i[create destroy index]
      delete 'likes', to: 'likes#destroy'
      resources :likes, only: :create
    end
    resources :regions, only: %i[show index]
    resources :panels, only: %i[show index]
    resources :slugs, only: :index
    resources :rooms, only: %i[index create]
    resources :feedbacks, only: :create
    resources :user_audio_trackings, only: %i[create update]
    resources :click_trackings, only: :create
    get 'authenticate', to: 'pages#authenticate'
  end

  devise_for :users, module: 'api/users',
                     path: '/api/users',
                     defaults: { format: :json }
end
