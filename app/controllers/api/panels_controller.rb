# frozen_string_literal: true

module Api
  class PanelsController < ApplicationController
    respond_to :json

    def index
      @categories = Category.all
    end

    # rubocop:disable Metrics/MethodLength
    def show
      @panel = Panel.find(params[:id])
      @category = @panel.category
      @statements_from_experts = @panel.statements
                                       .includes(:audio_file, :user)
                                       .accepted
                                       .from_experts
                                       .shuffle

      @statements_from_community = @panel.statements
                                         .includes(:audio_file)
                                         .accepted
                                         .from_community
                                         .sorted_by_likes
    end
    # rubocop:enable Metrics/MethodLength
  end
end
