# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  mount Web::Api => '/'
  authenticate :admin do
    resources :users, except: [:show]
    resources :panels, except: [:show]
    resources :categories, except: [:show]
    resources :organisations, except: [:show]
    root to: 'user#index'
  end
end
