# frozen_string_literal: true

module Api
  class PagesController < ApplicationController
    respond_to :json

    def authenticate
      authenticate_user!
      head :ok
    end
  end
end
