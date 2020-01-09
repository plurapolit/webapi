# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  authenticate :admin do
    resources :users, except: [:show]
    resources :panels, except: [:show]
    resources :categories, except: [:show]
    resources :organisations, except: [:show]
    root to: 'user#index'
  end

  namespace :api do
    resources :panels, only: [:index]
  end
end
