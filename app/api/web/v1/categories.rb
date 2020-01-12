# frozen_string_literal: true

module Web
  module V1
    class Categories < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :categories do
        desc 'Returns all categories with associated panels'
        get do
          categories = Category.all
          present categories
        end
      end
    end
  end
end
