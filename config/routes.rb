# frozen_string_literal: true

Rails.application.routes.draw do
  resources :organisations
  namespace :api do
    resources :panels, only: [:index]
  end
end
