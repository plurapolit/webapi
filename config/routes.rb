# frozen_string_literal: true

Rails.application.routes.draw do
  get 'pages/healthcheck'
  get 'pages/home'
  get '/healthcheck', to: 'pages#healthcheck'
  devise_for :admins
  authenticate :admin do
    root to: 'pages#home'
    resources :users, except: [:show]
    resources :panels, except: [:show]
    resources :categories, except: [:show]
    resources :organisations, except: [:show]
    resources :statements, except: [:show] do
      member do
        patch :accept
        patch :reject
      end
    end
  end

  namespace 'api', defaults: { format: :json } do
    resources :categories, only: :index
  end

  devise_for :users, module: 'api/users',
                     path: '/api/users',
                     defaults: { format: :json }
end
