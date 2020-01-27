# frozen_string_literal: true

module Api
  class SlugsController < ApplicationController
    respond_to :json

    def index
      @panels = Panel.all
    end
  end
end
