# frozen_string_literal: true

module Api
  class PagesController < ApplicationController
    respond_to :json

    def authenticate
      authenticate_user!

      render json: { user: current_user }, status: :ok
    end
  end
end
