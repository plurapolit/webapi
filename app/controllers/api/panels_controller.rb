# frozen_string_literal: true

module Api
  class PanelsController < ApplicationController
    respond_to :json

    def index
      @categories = Category.all
    end

    def show
      @panel = Panel.find(params[:id])
      @category = @panel.category
      @statements = @panel.statements.accepted
    end
  end
end
