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
      @statements_from_experts = @panel.statements.accepted.from_experts.shuffle
      @statements_from_community = @panel.statements.accepted.from_community.sorted_by_likes
    end
  end
end
