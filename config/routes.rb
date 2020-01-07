# frozen_string_literal: true

Rails.application.routes.draw do
  resources :panels, except: [:show]
  resources :categories, except: [:show]
  resources :organisations, except: [:show]
  namespace :api do
    resources :panels, only: [:index]
  end
end
