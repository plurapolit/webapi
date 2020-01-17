# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    respond_to :json
    before_action :authenticate_user!

    def index
      render json: {
        data: {
          categories: Category.all
        }
      }
    end
  end
end
